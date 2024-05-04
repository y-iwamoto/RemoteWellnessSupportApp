//
//  WorkDaySelectEditViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/03.
//

import Foundation

class WorkDaySelectEditViewModel: BaseViewModel {
    private let dataSource: ProfileDataSource
    var profile: Profile
    @Published var daysOfWeek: [[DayOfWeek]]
    @Published var workDays: [WorkDay]

    init(dataSource: ProfileDataSource = ProfileDataSource.shared, profile: Profile) {
        self.dataSource = dataSource
        self.profile = profile
        daysOfWeek = WorkDaySelectEditViewModel.initializeDaysOfWeek(with: profile.workDays)
        workDays = profile.workDays
    }

    func selectDayOfWeek(_ selectedDayOfWeek: DayOfWeek) {
        for (parentIndex, group) in daysOfWeek.enumerated() {
            if let childIndex = group.firstIndex(where: { $0.id == selectedDayOfWeek.id }) {
                daysOfWeek[parentIndex][childIndex].selected.toggle()
            }
        }
    }

    func updateDaysOfWeek() -> Bool {
        let isValid = daysOfWeek.contains { group in
            group.contains { $0.selected }
        }

        guard isValid else {
            setError(withMessage: "未選択です。")
            return false
        }

        do {
            profile.workDays = assignDayOfWeek()
            try dataSource.updateProfile(profile: profile)
            return true
        } catch {
            setError(withMessage: "曜日の更新に失敗しました")
        }
        return false
    }

    func assignDayOfWeek() -> [WorkDay] {
        var newWorkDays: [WorkDay] = []

        for group in daysOfWeek {
            for item in group {
                let workDay = WorkDay.allCases[item.id - 1]
                if item.selected {
                    newWorkDays.append(workDay)
                }
            }
        }
        return newWorkDays
    }

    private static func initializeDaysOfWeek(with workDays: [WorkDay]) -> [[DayOfWeek]] {
        var days = [
            [DayOfWeek(id: 1, labelName: "月", selected: false),
             DayOfWeek(id: 2, labelName: "火", selected: false),
             DayOfWeek(id: 3, labelName: "水", selected: false)],
            [
                DayOfWeek(id: 4, labelName: "木", selected: false),
                DayOfWeek(id: 5, labelName: "金", selected: false)
            ],
            [
                DayOfWeek(id: 6, labelName: "土", selected: false),
                DayOfWeek(id: 7, labelName: "日", selected: false)
            ]
        ]
        for workDay in workDays {
            for (parentIndex, group) in days.enumerated() {
                if let childIndex = group.firstIndex(where: { $0.id == workDay.rawValue + 1 }) {
                    days[parentIndex][childIndex].selected = true
                }
            }
        }
        return days
    }
}
