//
//  WeekPhysicalConditionListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/10.
//

import Foundation

class WeekPhysicalConditionListViewModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSource
    @Published var dateWithPhysicalConditions: [DateWithPhysicalCondition] = []
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    init(dataSource: PhysicalConditionDataSource = .shared) {
        self.dataSource = dataSource
    }

    func fetchDatesWithPhysicalCondition() {
        do {
            let predicate = createPredicateForRecentOneWeekPhysicalConditions()

            let physicalConditions = try dataSource.fetchPhysicalConditions(predicate: predicate)
            assignWeekPhysicalConditions(physicalConditions)
        } catch {
            setError(withMessage: "体調データの取得に失敗しました")
        }
    }

    private func assignWeekPhysicalConditions(_ physicalConditions: [PhysicalCondition]) {
        if physicalConditions.isEmpty {
            dateWithPhysicalConditions = []
        } else {
            dateWithPhysicalConditions = convertToDateWithPhysicalConditions(physicalConditions)
        }
    }

    private func convertToDateWithPhysicalConditions(_ conditions: [PhysicalCondition]) -> [DateWithPhysicalCondition] {
        let calendar = Calendar.current
        let groupedConditions = Dictionary(grouping: conditions) { condition -> Date in
            calendar.startOfDay(for: condition.entryDate)
        }

        let sortedDates = groupedConditions.keys.sorted()

        let dateWithPhysicalCondition: [DateWithPhysicalCondition] = sortedDates.map { date -> DateWithPhysicalCondition in
            DateWithPhysicalCondition(date: date)
        }

        return dateWithPhysicalCondition
    }

    private func createPredicateForRecentOneWeekPhysicalConditions() -> Predicate<PhysicalCondition> {
        let currentTime = Date()
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentTime)
        let predicate = #Predicate<PhysicalCondition> { physicalCondition in
            physicalCondition.entryDate > (oneWeekAgo ?? currentTime)
        }
        return predicate
    }

    private func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
}
