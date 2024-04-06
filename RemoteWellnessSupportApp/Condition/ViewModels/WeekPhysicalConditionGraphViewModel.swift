//
//  WeekPhysicalConditionGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/09.
//

import Foundation

class WeekPhysicalConditionGraphViewModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSource

    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    init(dataSource: PhysicalConditionDataSource = .shared) {
        self.dataSource = dataSource
    }

    @Published var weekPhysicalConditions: [GraphValue] = []

    func fetchWeekPhysicalConditions() {
        do {
            let predicate = createPredicateForRecentOneWeekPhysicalConditions()

            let physicalConditions = try dataSource.fetchPhysicalConditions(predicate: predicate)
            assignWeekPhysicalConditions(physicalConditions)
        } catch {
            setError(withMessage: "体調データの取得に失敗しました")
        }
    }

    private func createPredicateForRecentOneWeekPhysicalConditions() -> Predicate<PhysicalCondition> {
        let currentTime = Date()
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentTime)
        let predicate = #Predicate<PhysicalCondition> { physicalCondition in
            physicalCondition.entryDate > (oneWeekAgo ?? currentTime)
        }
        return predicate
    }

    private func assignWeekPhysicalConditions(_ physicalConditions: [PhysicalCondition]) {
        if physicalConditions.isEmpty {
            weekPhysicalConditions = []
        } else {
            weekPhysicalConditions = convertToGraphPhysicalConditions(physicalConditions)
        }
    }

    private func convertToGraphPhysicalConditions(_ conditions: [PhysicalCondition]) -> [GraphValue] {
        let calendar = Calendar.current
        let currentTime = Date()
        let dateRange = (0 ... 7).map { date -> Date in
            let startOfDay = calendar.date(byAdding: .day, value: -date, to: currentTime)!
            return calendar.startOfDay(for: startOfDay)
        }

        let groupedConditions = Dictionary(grouping: conditions) { condition -> Date in
            calendar.startOfDay(for: condition.entryDate)
        }

        let graphConditions: [GraphValue] = dateRange.map { date -> GraphValue in
            if let conditionsForDay = groupedConditions[date] {
                let averageRating = conditionsForDay.reduce(0) { $0 + $1.rating } / conditionsForDay.count
                return GraphValue(timeZone: date, rateAverage: averageRating)
            } else {
                return GraphValue(timeZone: date, rateAverage: 0)
            }
        }

        return graphConditions
    }

    private func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
}
