//
//  PomodoroTimerViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import Foundation
import SwiftUI

class PomodoroTimerViewModel: BaseViewModel {
    private let dataSource: PomodoroDataSource
    static let MaxTimer: Int = 1500
    static let BreakTime: Int = 300
    @Published var timerMode: PomodoroTimerMode = .initial
    @Published var secondsLeft: Int = MaxTimer
    @Published var currentMaxTime: Int = MaxTimer
    @Published var completedPomodoroCount = 0
    var progress: CGFloat {
        CGFloat(secondsLeft) / CGFloat(currentMaxTime)
    }

    var foregroundColor: Color {
        switch timerMode {
        case .running:
            Color.green
        case .breakMode:
            Color.blue
        default:
            Color.red
        }
    }

    let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .full
        formatter.calendar?.locale = Locale(identifier: "ja_JP")
        return formatter
    }()

    var pomodoroGroupId: UUID?
    var timer = Timer()

    init(dataSource: PomodoroDataSource = PomodoroDataSource.shared) {
        self.dataSource = dataSource
        super.init()
        let workTimeEndPomodoros = fetchCount()
        completedPomodoroCount = workTimeEndPomodoros.count
    }

    func startTimer() {
        timer.invalidate()
        secondsLeft = PomodoroTimerViewModel.MaxTimer
        currentMaxTime = PomodoroTimerViewModel.MaxTimer
        timerMode = .running
        pomodoroGroupId = UUID()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if secondsLeft == 0 {
                if timerMode == .running {
                    endMainTimer()
                } else {
                    resetTimer()
                }
            } else {
                secondsLeft -= 1
            }
        }
    }

    func startBraekMode() {
        timer.invalidate()
        secondsLeft = PomodoroTimerViewModel.BreakTime
        currentMaxTime = PomodoroTimerViewModel.BreakTime
        timerMode = .breakMode
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if secondsLeft == 0 {
                endBreakTimer()
            } else {
                secondsLeft -= 1
            }
        }
    }

    func pauseTimer() {
        timer.invalidate()
        timerMode = .paused
    }

    func resetTimer() {
        timer.invalidate()
        secondsLeft = PomodoroTimerViewModel.MaxTimer
        currentMaxTime = PomodoroTimerViewModel.MaxTimer
        timerMode = .initial
        pomodoroGroupId = nil
    }

    func resumeTimer() {
        if timerMode == .paused {
            if currentMaxTime == PomodoroTimerViewModel.BreakTime {
                timerMode = .breakMode
            } else {
                timerMode = .running
            }
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self else { return }
                if secondsLeft == 0 {
                    if timerMode == .running {
                        endMainTimer()
                    } else {
                        resetTimer()
                    }
                } else {
                    secondsLeft -= 1
                }
            }
        }
    }

    func endMainTimer() {
        timer.invalidate()
        secondsLeft = PomodoroTimerViewModel.BreakTime
        currentMaxTime = PomodoroTimerViewModel.BreakTime
        timerMode = .initial
        guard let pomodoroGroupId else {
            setError(withMessage: "不正な値です")
            return
        }
        let pomodoro = Pomodoro(pomodoroGroupId: pomodoroGroupId.uuidString, activityType: .workTime)
        do {
            try dataSource.insertPomodoro(pomodoro: pomodoro)

            let workTimeEndPomodoros = fetchCount()
            completedPomodoroCount = workTimeEndPomodoros.count
        } catch {
            setError(withMessage: "登録処理に失敗しました", error: error)
        }
    }

    func fetchCount() -> [Pomodoro] {
        do {
            let predicate = try createPredicateForOneDayPomodoro()
            let pomodoros = try dataSource.fetchPomodoros(predicate: predicate)
            let workTimeEndPomodoros = pomodoros.filter {
                $0.activityType == .workTime
            }
            return workTimeEndPomodoros
        } catch {
            setError(withMessage: "取得処理に失敗しました", error: error)
        }
        return []
    }

    func endBreakTimer() {
        guard let pomodoroGroupId else {
            fatalError("不正な値です")
        }
        let pomodoro = Pomodoro(pomodoroGroupId: pomodoroGroupId.uuidString, activityType: .breakTime)

        do {
            try dataSource.insertPomodoro(pomodoro: pomodoro)
        } catch {
            setError(withMessage: "登録処理に失敗しました", error: error)
        }
        resetTimer()
    }

    private func createPredicateForOneDayPomodoro() throws -> Predicate<Pomodoro> {
        let (startOfDay, endOfDay) = try dayPeriod(for: Date())
        let workTimeType = PomodoroActivityType.workTime
        let predicate = #Predicate<Pomodoro> { pomodoro in

            pomodoro.registeredAt >= startOfDay && pomodoro.registeredAt < endOfDay
            // TODO: xcodeのバージョンを上げたら直るか確認
            // pomodoro.activityType == workTimeType
        }
        return predicate
    }

    private func dayPeriod(for date: Date) throws -> (startOfDay: Date, endOfDay: Date) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDayComponents = DateComponents(day: 1)
        guard let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay) else {
            throw DateError.calculationFailed(description: "Failed to calculate the end of day")
        }
        return (startOfDay, endOfDay)
    }
}
