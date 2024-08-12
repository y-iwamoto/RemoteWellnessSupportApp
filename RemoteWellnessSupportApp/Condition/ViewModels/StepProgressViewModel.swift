//
//  StepProgressViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/27.
//

import Foundation
import HealthKit

class StepProgressViewModel: BaseViewModel {
    private let profileDataSource: ProfileDataSource
    private let manager: HealthKitManager
    private let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

    @Published var stepGoalProgress = CGFloat(0.0)
    @Published var currentTotalStepIntake = 0
    @Published var totalStepGoal = 0

    init(profileDataSource: ProfileDataSource = .shared) {
        self.profileDataSource = profileDataSource
        manager = HealthKitManager()
    }

    @MainActor
    func aggregateStep() {
        let calendar = Calendar.current
        let nowTime = Date()
        let oneDateAgo = calendar.date(byAdding: .day, value: -1, to: nowTime)!
        let startOfDayOneDateAgo = calendar.startOfDay(for: oneDateAgo)
        let interval = DateComponents(day: 1)

        Task {
            do {
                let steps = try await manager.fetchQuery(startOfDay: startOfDayOneDateAgo,
                                                         endOfDay: nowTime, interval: interval, sampleType: stepType)
                currentTotalStepIntake = steps.isEmpty ? 0 : Int((steps.first?.quantity.doubleValue(for: HKUnit.count()))!)
                totalStepGoal = try calculateTotalStepGoal()
                stepGoalProgress = calculateStepProgress()
            } catch {
                setError(withMessage: "歩数の取得処理に失敗しました", error: error)
            }
        }
    }

    private func calculateTotalStepGoal() throws -> Int {
        guard let profile = try profileDataSource.fetchProfile() else {
            throw SwiftDataError.notFound(description: "Failed to fetch Profile")
        }
        let workTimeIntervalInHours = profile.workTimeTo.timeIntervalSince(profile.workTimeFrom) / 3600

        let breakTimeIntervalInMinutes = profile.restTimePeriods.reduce(into: 0) { total, period in
            let intervalInSeconds = period.toTime.timeIntervalSince(period.fromTime)
            let intervalInMinutes = intervalInSeconds / 60
            total += intervalInMinutes
        }
        let breakTimeIntervalInHours = breakTimeIntervalInMinutes / 60
        let workTimeInHoursExcludingBreaks = workTimeIntervalInHours - breakTimeIntervalInHours
        // TODO: 後でまるまるロジックを削除する必要あり
        return 0
        // return Int(profile.stepGoal * workTimeInHoursExcludingBreaks)
    }

    private func calculateStepProgress() -> CGFloat {
        CGFloat(Double(currentTotalStepIntake) / Double(totalStepGoal))
    }
}
