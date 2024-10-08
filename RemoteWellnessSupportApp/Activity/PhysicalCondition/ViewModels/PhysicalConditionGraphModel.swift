//
//  PhysicalConditionGraphModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/24.
//

import Foundation

class PhysicalConditionGraphModel: BaseGraphViewModel {
    private let physicalConditionDataSource: PhysicalConditionDataSource

    init(physicalConditionDataSource: PhysicalConditionDataSource = .shared,
         profileDataSource: ProfileDataSource = .shared,
         targetDate: Date = Date()) {
        self.physicalConditionDataSource = physicalConditionDataSource
        super.init(profileDataSource: profileDataSource, targetDate: targetDate)
    }

    @Published var targetDatePhysicalConditions: [GraphValue] = []

    func fetchPhysicalConditions() {
        do {
            let predicate = try createPredicateForLastDay()
            let physicalConditions = try physicalConditionDataSource.fetchPhysicalConditions(predicate: predicate)
            try assignTargetDatePhysicalConditions(physicalConditions)
        } catch {
            setError(withMessage: "体調データの取得に失敗しました", error: error)
        }
    }

    private func assignTargetDatePhysicalConditions(_ physicalConditions: [PhysicalCondition]) throws {
        if !physicalConditions.isEmpty {
            targetDatePhysicalConditions = try convertToGraphPhysicalConditions(physicalConditions)
        }
    }

    private func convertToGraphPhysicalConditions(_ conditions: [PhysicalCondition]) throws -> [GraphValue] {
        var results: [GraphValue] = []
        let calendar = Calendar.current
        do {
            let hoursRange = try calculateWorkHoursRange()

            for hour in hoursRange {
                let averageRating = calculateAverageRatingForHour(conditions, hour: hour)
                if let timeZone = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: targetDate) {
                    results.append(GraphValue(timeZone: timeZone, rateAverage: Int(averageRating)))
                }
            }
            return results

        } catch {
            throw error
        }
    }

    private func calculateAverageRatingForHour(_ conditions: [PhysicalCondition], hour: Int) -> Double {
        let calendar = Calendar.current
        let conditionsInHour = conditions.filter { condition in
            let hourOfCondition = calendar.component(.hour, from: condition.entryDate)
            return hourOfCondition == hour
        }
        let totalRating = conditionsInHour.reduce(noEntryValueForSpecificTime) { $0 + $1.rating }
        let averageRating: Double = if conditionsInHour.isEmpty {
            Double(noEntryValueForSpecificTime)
        } else {
            round(Double(totalRating) / Double(conditionsInHour.count))
        }
        return averageRating
    }

    private func createPredicateForLastDay() throws -> Predicate<PhysicalCondition> {
        do {
            let (startOfDay, endOfDay) = try dayPeriod(for: targetDate)
            let predicate = #Predicate<PhysicalCondition> { physicalCondition in
                physicalCondition.entryDate >= startOfDay && physicalCondition.entryDate < endOfDay
            }
            return predicate
        } catch {
            throw error
        }
    }
}
