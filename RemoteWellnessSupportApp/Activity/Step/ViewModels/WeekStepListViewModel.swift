//
//  WeekStepListViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import Foundation
import HealthKit

@MainActor
class WeekStepListViewModel: BaseViewModel {
    var manager: HealthKitManager
    let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    @Published private(set) var steps: [HKQuantitySample] = []

    override init() {
        manager = HealthKitManager()
        super.init()
    }

    func fetchSteps() async {
        let calendar = Calendar.current
        let nowTime = Date()
        let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: nowTime)!
        let startOfDayOneWeekAgo = calendar.startOfDay(for: oneWeekAgo)
        let interval = DateComponents(day: 1)

        do {
            steps = try await manager.fetchQuery(startOfDay: startOfDayOneWeekAgo, endOfDay: nowTime, interval: interval, sampleType: stepType)
        } catch {
            setError(withMessage: "歩数の取得処理に失敗しました", error: error)
        }
    }
}
