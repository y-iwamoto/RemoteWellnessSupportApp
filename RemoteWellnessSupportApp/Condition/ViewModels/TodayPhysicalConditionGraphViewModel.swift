//
//  TodayPhysicalConditionGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/24.
//

import Foundation

class TodayPhysicalConditionGraphViewModel: ObservableObject {
    private let dataSource: PhysicalConditionDataSource
    private let noEntryValueForSpecificTime = 0

    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    init(dataSource: PhysicalConditionDataSource = .shared) {
        self.dataSource = dataSource
    }

    @Published var todayPhysicalConditions: [GraphPhysicalCondition] = []

    func fetchPhysicalConditions() {
        do {
            let predicate = createPredicateForLastDay()

            let physicalConditions = try dataSource.fetchPhysicalConditions(predicate: predicate)
            setTodayPhysicalConditions(physicalConditions)
        } catch {
            print("fetch PhysicalCondition Error: \(error)")
            setError(withMessage: "体調データの取得に失敗しました")
        }
    }

    private func createPredicateForLastDay() -> Predicate<PhysicalCondition> {
        let currentTime = Date()
        let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: currentTime)
        let predicate = #Predicate<PhysicalCondition> { physicalCondition in
            physicalCondition.entryDate > (oneDayAgo ?? currentTime)
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
        let currentHour = calendar.component(.hour, from: Date())

        // TODO: 現在はhoursRangeを特定値で固定にしているが別途、ここも動的になる
        let hoursRange: Range<Int> = currentHour < 9 ? 0 ..< currentHour + 1 : 9 ..< 19

        for hour in hoursRange {
            let averageRating = calculateAverageRatingForHour(conditions, hour: hour)
            if let timeZone = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: Date()) {
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
