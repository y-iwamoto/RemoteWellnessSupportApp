//
//  ProfileScreenViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/22.
//

import Foundation

class ProfileScreenViewModel: BaseViewModel {
    private let dataSource: ProfileDataSource
    @Published var nickname = ""
    @Published var workDays: [WorkDay] = [.monday, .tuesday, .wednesday, .thursday, .friday]
    @Published var workTimeFrom: TimeSelection
    @Published var workTimeTo: TimeSelection
    @Published var hydrationGoal = ""
    @Published var stepGoal = ""
    @Published var restTimePeriodSections: [RestTimePeriodSection]

    init(dataSource: ProfileDataSource = ProfileDataSource.shared) {
        self.dataSource = dataSource

        workTimeFrom = ProfileScreenViewModel.timeSelection(for: 9)
        workTimeTo = ProfileScreenViewModel.timeSelection(for: 18)
        restTimePeriodSections = [RestTimePeriodSection(fromTime: ProfileScreenViewModel.timeSelection(for: 12),
                                                        toTime: ProfileScreenViewModel.timeSelection(for: 13))]
    }

    func saveProfile() -> Bool {
        guard let hydrationGoalDoubleValue = Double(hydrationGoal), let stepGoalDoubleValue = Double(stepGoal) else {
            setError(withMessage: "入力された目標値が無効です")
            return false
        }

        let restTimePeriods = restTimePeriodSections.map { section in
            RestTimePeriod(fromTime: section.fromTime.selectedTime, toTime: section.toTime.selectedTime)
        }

        let profile = Profile(nickname: nickname, workDays: workDays, workTimeFrom: workTimeFrom.selectedTime,
                              workTimeTo: workTimeTo.selectedTime, hydrationGoal: hydrationGoalDoubleValue, stepGoal: stepGoalDoubleValue,
                              restTimePeriods: restTimePeriods)

        do {
            try dataSource.insertProfile(profile: profile)
        } catch {
            setError(withMessage: "プロファイル情報の登録に失敗しました")
            return false
        }
        return true
    }

    private static func timeSelection(for hour: Int) -> TimeSelection {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: Date())

        dateComponents.hour = hour
        dateComponents.minute = 0
        dateComponents.second = 0
        return TimeSelection(selectedTime: calendar.date(from: dateComponents)!)
    }
}
