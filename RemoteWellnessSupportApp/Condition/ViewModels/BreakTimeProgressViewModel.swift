//
//  BreakTimeProgressViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/27.
//

import Foundation

class BreakTimeProgressViewModel: BaseViewModel {
    private let profileDataSource: ProfileDataSource
    private let pomodoroDataSource: PomodoroDataSource

    @Published var breakTimeProgress = CGFloat(0.0)
    @Published var currentTotalBreakTimeIntake = 0
    @Published var totalBreakTimeGoal = 0

    init(profileDataSource: ProfileDataSource = .shared, pomodoroDataSource: PomodoroDataSource = .shared) {
        self.profileDataSource = profileDataSource
        self.pomodoroDataSource = pomodoroDataSource
        super.init()
        setupNotifications()
        aggregateBreakTime()
    }

    func aggregateBreakTime() {
        do {
            let pomodoros = try fetchTodayPomodoro()
            totalBreakTimeGoal = try calculateTotalBreakTimeGoal()
            currentTotalBreakTimeIntake = calculateTotalBreakTime(pomodoros: pomodoros)
            breakTimeProgress = calculateBreakTimeProgress()
        } catch {
            setError(withMessage: "休憩データの取得に失敗しました")
        }
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: .didUpdatePomodoroData, object: nil)
    }

    @objc private func fetchData() {
        aggregateBreakTime()
    }

    private func fetchTodayPomodoro() throws -> [Pomodoro] {
        let predicate = try createPredicateForTargetDate()
        return try pomodoroDataSource.fetchPomodoros(predicate: predicate)
    }

    private func calculateTotalBreakTimeGoal() throws -> Int {
        guard let profile = try profileDataSource.fetchProfile() else {
            throw SwiftDataError.notFound(description: "Failed to fetch Profile")
        }
        let workTimeIntervalInHours = profile.workTimeTo.timeIntervalSince(profile.workTimeFrom) / 3600

        let breakTimeIntervalInMinutes = profile.restTimePeriods.reduce(into: 0) { total, period in
            let intervalInSeconds = period.toTime.timeIntervalSince(period.fromTime)
            let intervalInMinutes = intervalInSeconds / 60
            total += intervalInMinutes
        }
        let breakTimeIntervalInHours = breakTimeIntervalInMinutes / 60
        let workTimeInHoursExcludingBreaks = workTimeIntervalInHours - breakTimeIntervalInHours

        let pomodoroCicleMinute = 30

        return (Int(workTimeInHoursExcludingBreaks) * 60) / pomodoroCicleMinute
    }

    private func calculateTotalBreakTime(pomodoros: [Pomodoro]) -> Int {
        pomodoros.filter { $0.activityType == .breakTime }.count
    }

    private func calculateBreakTimeProgress() -> CGFloat {
        CGFloat(Double(currentTotalBreakTimeIntake) / Double(totalBreakTimeGoal))
    }

    private func createPredicateForTargetDate() throws -> Predicate<Pomodoro> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDayComponents = DateComponents(day: 1)
        guard let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay) else {
            throw DateError.calculationFailed(description: "Failed to calculate the end of day")
        }
        let predicate = #Predicate<Pomodoro> { pomodoro in
            pomodoro.registeredAt >= startOfDay && pomodoro.registeredAt < endOfDay
        }
        return predicate
    }
}
