//
//  StepGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/09.
//

import Foundation
import HealthKit

@MainActor
class StepGraphViewModel: BaseIncrementalYLabelGraphViewModel {
    var manager: HealthKitManager
    let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

    init() {
        manager = HealthKitManager()
        super.init()
    }

    @Published var targetDateSteps: [GraphValue] = []
    @Published var stepRateYGraphRange: ClosedRange<Int> = 0 ... StepRating.highDefaultStepCount.rawValue
    @Published var stepRatingYGraphValues: [Int] = []

    func authorizeHealthKit() async {
        do {
            try await manager.authorizeHealthKit(toShare: [], read: [stepType])
        } catch {
            setError(withMessage: "ヘルスケアの認証処理に失敗しました", error: error)
        }
    }

    func fetchStepCount() async {
        let nowTime = Date()
        let startOfDay = Calendar.current.startOfDay(for: nowTime)
        let interval = DateComponents(hour: 1)

        do {
            let samples = try await manager.fetchQuery(startOfDay: startOfDay, endOfDay: nowTime, interval: interval, sampleType: stepType)
            try assignTargetDateSteps(samples)
        } catch {
            setError(withMessage: "歩数の取得処理に失敗しました", error: error)
        }
    }

    private func assignTargetDateSteps(_ steps: [HKQuantitySample]) throws {
        if !steps.isEmpty {
            let (hoursRange, groupedSteps) = try calculateDateRangeAndGroupedSteps(steps)
            targetDateSteps = convertToGraphValues(dateRange: hoursRange, groupedValues: groupedSteps)
            stepRatingYGraphValues = convertToYGraphLabelValues(dateRange: hoursRange, groupedGraphValues: groupedSteps,
                                                                initialRatingValues: [0] + HydrationRating.allCases.map(\.rawValue))
            stepRateYGraphRange = convertToStepRateRange()
        }
    }

    private func calculateDateRangeAndGroupedSteps(_ steps: [HKQuantitySample]) throws -> ([Date], [Date: [StepSample]]) {
        let calendar = Calendar.current
        let hoursRange = try calculateWorkHoursRange()

        let currentDate = Date()
        let dates = hoursRange.compactMap { hour -> Date? in
            calendar.date(bySettingHour: hour, minute: 0, second: 0, of: currentDate)
        }

        let groupedSteps = Dictionary(grouping: steps) { step -> Date in
            let hour = calendar.component(.hour, from: step.startDate)
            let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: currentDate) ?? currentDate
            return date
        }

        let conditionsInHour = dates.reduce(into: [Date: [StepSample]]()) { result, date in
            result[date] = groupedSteps[date]?.map(StepSample.init) ?? []
        }

        return (dates, conditionsInHour)
    }

    private func convertToStepRateRange() -> ClosedRange<Int> {
        let stepRatingMax = stepRatingYGraphValues.max() ?? StepRating.highDefaultStepCount.rawValue
        return noEntryValueForSpecificTime ... stepRatingMax
    }
}
