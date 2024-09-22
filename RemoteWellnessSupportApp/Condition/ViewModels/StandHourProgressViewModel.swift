//
//  StandHourProgressViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/27.
//

import Foundation
import HealthKit

class StandHourProgressViewModel: BaseViewModel {
    private let profileDataSource: ProfileDataSource
    private let manager: HealthKitManager
    private let standingHourType = HKObjectType.categoryType(forIdentifier: .appleStandHour)!

    @Published var standHourGoalProgress = CGFloat(0.0)
    @Published var currentTotalStandHourIntake = 0
    @Published var totalStandHourGoal = 0

    init(profileDataSource: ProfileDataSource = .shared) {
        self.profileDataSource = profileDataSource
        manager = HealthKitManager()
    }

    @MainActor
    func aggregateStep() {
        let calendar = Calendar.current
        let nowTime = Date()
        let oneDateAgo = calendar.date(byAdding: .hour, value: -1, to: nowTime)!
        let startOfDayOneDateAgo = calendar.startOfDay(for: oneDateAgo)

        Task {
            do {
                let standHours = try await manager.fetchAppleStandHourData(startOfDay: startOfDayOneDateAgo, endOfDay: nowTime)
                if let firstValue = standHours.first?.value {
                    currentTotalStandHourIntake = firstValue
                } else {
                    currentTotalStandHourIntake = 0
                }

                totalStandHourGoal = 1
                standHourGoalProgress = calculateStandHourProgress()
            } catch {
                setError(withMessage: "立ち上がり状態の取得処理に失敗しました", error: error)
            }
        }
    }

    private func calculateStandHourProgress() -> CGFloat {
        CGFloat(Double(currentTotalStandHourIntake) / Double(totalStandHourGoal))
    }
}
