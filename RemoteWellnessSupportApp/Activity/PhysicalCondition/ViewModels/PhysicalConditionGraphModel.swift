//
//  PhysicalConditionGraphModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/24.
//

import Foundation

class PhysicalConditionGraphModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSource
    private let noEntryValueForSpecificTime = 0
    private let targetDate: Date

    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    init(dataSource: PhysicalConditionDataSource = .shared, targetDate: Date = Date()) {
        self.dataSource = dataSource
        self.targetDate = targetDate
    }

    @Published var todayPhysicalConditions: [GraphPhysicalCondition] = []

    func fetchPhysicalConditions() {
        do {
            let predicate = createPredicateForLastDay()

            let physicalConditions = try dataSource.fetchPhysicalConditions(predicate: predicate)

            setTodayPhysicalConditions(physicalConditions)
        } catch {
            setError(withMessage: "体調データの取得に失敗しました")
        }
    }

    private func createPredicateForLastDay() -> Predicate<PhysicalCondition> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: targetDate)
        let endOfDayComponents = DateComponents(day: 1)
        let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay)!
        let predicate = #Predicate<PhysicalCondition> { physicalCondition in
            physicalCondition.entryDate >= startOfDay && physicalCondition.entryDate < endOfDay
        }
        return predicate
    }

    private func setTodayPhysicalConditions(_ physicalConditions: [PhysicalCondition]) {
        if physicalConditions.isEmpty {
            todayPhysicalConditions = []
        } else {
            todayPhysicalConditions = convertToGraphPhysicalConditions(physicalConditions)
        }
    }

    private func convertToGraphPhysicalConditions(_ conditions: [PhysicalCondition]) -> [GraphPhysicalCondition] {
        var results: [GraphPhysicalCondition] = []
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: targetDate)
        // TODO: 現在はhoursRangeを特定値で固定にしているが別途、ここも動的になる
        let startHour = 0
        let endHour = 9
        let defaultEndHour = 19
        let hoursRange: Range<Int> = (currentHour > startHour && currentHour < endHour) ? startHour ..< currentHour + 1 : endHour ..< defaultEndHour

        for hour in hoursRange {
            let averageRating = calculateAverageRatingForHour(conditions, hour: hour)
            if let timeZone = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: targetDate) {
                results.append(GraphPhysicalCondition(timeZone: timeZone, rateAverage: Int(averageRating)))
            }
        }
        return results
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

    private func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
}
