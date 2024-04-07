//
//  WeekPhysicalConditionGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/09.
//

import Foundation

class WeekPhysicalConditionGraphViewModel: BaseSelectedDateGraphViewModel {
    private let physicalConditionDataSource: PhysicalConditionDataSource

    init(physicalConditionDataSource: PhysicalConditionDataSource = .shared,
         profileDataSource: ProfileDataSource = .shared) {
        self.physicalConditionDataSource = physicalConditionDataSource
        super.init(profileDataSource: profileDataSource)
    }

    @Published var weekPhysicalConditions: [GraphValue] = []

    func fetchWeekPhysicalConditions() {
        do {
            let predicate = createPredicateForRecentOneWeekPhysicalConditions()

            let physicalConditions = try physicalConditionDataSource.fetchPhysicalConditions(predicate: predicate)
            try assignWeekPhysicalConditions(physicalConditions)
        } catch {
            setError(withMessage: "体調データの取得に失敗しました", error: error)
        }
    }

    private func assignWeekPhysicalConditions(_ physicalConditions: [PhysicalCondition]) throws {
        do {
            if !physicalConditions.isEmpty {
                let (dateRange, groupedConditions) = try calculateDateRangeAndGroupedPhysicalConditions(physicalConditions)
                weekPhysicalConditions = convertToGraphPhysicalConditions(dateRange: dateRange, groupedConditions: groupedConditions)
            }
        } catch {
            throw error
        }
    }

    private func calculateDateRangeAndGroupedPhysicalConditions(_ conditions: [PhysicalCondition]) throws -> ([Date], [Date: [PhysicalCondition]]) {
        let calendar = Calendar.current
        do {
            let dateRange = try calculateDateRange()
            let groupedConditions = Dictionary(grouping: conditions) { condition -> Date in
                calendar.startOfDay(for: condition.entryDate)
            }
            return (dateRange, groupedConditions)
        } catch {
            throw error
        }
    }

    private func convertToGraphPhysicalConditions(dateRange: [Date], groupedConditions: [Date: [PhysicalCondition]]) -> [GraphValue] {
        let graphConditions: [GraphValue] = dateRange.map { date -> GraphValue in
            if let conditionsForDay = groupedConditions[date] {
                let averageRating = conditionsForDay.reduce(noEntryValueForSpecificTime) { $0 + $1.rating } / conditionsForDay.count
                return GraphValue(timeZone: date, rateAverage: averageRating)
            } else {
                return GraphValue(timeZone: date, rateAverage: noEntryValueForSpecificTime)
            }
        }
        return graphConditions
    }

    private func createPredicateForRecentOneWeekPhysicalConditions() -> Predicate<PhysicalCondition> {
        let oneWeekAgo = dateOneWeekAgo()
        let predicate = #Predicate<PhysicalCondition> { physicalCondition in
            physicalCondition.entryDate > oneWeekAgo
        }
        return predicate
    }
}
