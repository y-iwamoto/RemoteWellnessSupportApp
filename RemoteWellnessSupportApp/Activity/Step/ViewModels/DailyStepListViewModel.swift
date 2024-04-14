//
//  DailyStepListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import Foundation
import HealthKit

@MainActor
class DailyStepListViewModel: BaseViewModel {
    let targetDate: Date
    var manager: HealthKitManager
    let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    @Published private(set) var steps: [HKQuantitySample] = []

    init(targetDate: Date = Date()) {
        manager = HealthKitManager()
        self.targetDate = targetDate
    }

    func fetchSteps() async {
        let nowTime = Date()
        let startOfDay = Calendar.current.startOfDay(for: nowTime)
        let interval = DateComponents(hour: 1)

        do {
            steps = try await manager.fetchQuery(startOfDay: startOfDay, endOfDay: nowTime, interval: interval, sampleType: stepType)
        } catch {
            setError(withMessage: "歩数の取得処理に失敗しました", error: error)
        }
    }
}
