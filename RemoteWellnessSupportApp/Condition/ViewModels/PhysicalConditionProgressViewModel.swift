//
//  PhysicalConditionProgressViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/08/31.
//

import Foundation

final class PhysicalConditionProgressViewModel: BaseViewModel {
    private let physicalConditionDataSource: PhysicalConditionDataSource
    private let profileDataSource: ProfileDataSource

    @Published var physicalConditionGoalProgress = CGFloat(0.0)
    @Published var currentTotalPhysicalConditionAverage = 0.0
    @Published var totalPhysicalConditionGoal = 0

    init(physicalConditionDataSource: PhysicalConditionDataSource = .shared, profileDataSource: ProfileDataSource = .shared) {
        self.physicalConditionDataSource = physicalConditionDataSource
        self.profileDataSource = profileDataSource
    }

    func aggregatePhysicalCondition() {
        do {
            let physicalCondition = try fetchTodayPhysicalCondition()
            if physicalCondition.isEmpty { return }
            totalPhysicalConditionGoal = try calculateTotalPhysicalConditionGoal(todayPhysicalCondition: physicalCondition)
            currentTotalPhysicalConditionAverage = calculateTodayAveragePhysicalCondition(todayPhysicalCondition: physicalCondition)
            physicalConditionGoalProgress = calculatePhysicalConditionProgress(todayPhysicalCondition: physicalCondition)

        } catch {
            setError(withMessage: "体調データの取得に失敗しました")
        }
    }

    private func fetchTodayPhysicalCondition() throws -> [PhysicalCondition] {
        let predicate = try createPredicateForTargetDate()
        return try physicalConditionDataSource.fetchPhysicalConditions(predicate: predicate)
    }

    private func createPredicateForTargetDate() throws -> Predicate<PhysicalCondition> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDayComponents = DateComponents(day: 1)
        guard let endOfDay = calendar.date(byAdding: endOfDayComponents, to: startOfDay) else {
            throw DateError.calculationFailed(description: "Failed to calculate the end of day")
        }
        let predicate = #Predicate<PhysicalCondition> { physicalCondition in
            physicalCondition.entryDate >= startOfDay && physicalCondition.entryDate < endOfDay
        }
        return predicate
    }

    private func calculateTotalPhysicalConditionGoal(todayPhysicalCondition: [PhysicalCondition]) throws -> Int {
        guard !todayPhysicalCondition.isEmpty else {
            return 0
        }
        return todayPhysicalCondition.count * 5
    }

    private func calculateTodayAveragePhysicalCondition(todayPhysicalCondition: [PhysicalCondition]) -> Double {
        let totalPhysicalCondition = todayPhysicalCondition.reduce(0) { $0 + $1.rating }
        return Double(totalPhysicalCondition) / Double(todayPhysicalCondition.count)
    }

    private func calculatePhysicalConditionProgress(todayPhysicalCondition: [PhysicalCondition]) -> CGFloat {
        let totalPhysicalCondition = todayPhysicalCondition.reduce(0) { $0 + $1.rating }
        return Double(totalPhysicalCondition) / Double(totalPhysicalConditionGoal)
    }
}
