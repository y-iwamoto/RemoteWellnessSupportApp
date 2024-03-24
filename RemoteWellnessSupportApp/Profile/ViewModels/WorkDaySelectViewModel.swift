//
//  WorkDaySelectViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import Foundation

class WorkDaySelectViewModel: FormBaseViewModel {
    @Published var daysOfWeek: [[DayOfWeek]]

    init(workDays: [WorkDay]) {
        daysOfWeek = WorkDaySelectViewModel.initializeDaysOfWeek(with: workDays)
    }

    func selectDayOfWeek(_ selectedDayOfWeek: DayOfWeek) {
        for (parentIndex, group) in daysOfWeek.enumerated() {
            if let childIndex = group.firstIndex(where: { $0.id == selectedDayOfWeek.id }) {
                daysOfWeek[parentIndex][childIndex].selected.toggle()
            }
        }
    }

    func assignDayOfWeek(_: [WorkDay]) -> [WorkDay] {
        var newWorkDays: [WorkDay] = []

        let isValid = daysOfWeek.contains { group in
            group.contains { $0.selected }
        }

        guard isValid else {
            setError(withMessage: "未選択です。")
            return newWorkDays
        }

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
