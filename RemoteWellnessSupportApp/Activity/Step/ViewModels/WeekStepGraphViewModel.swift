//
//  WeekStepGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/11.
//

import Foundation
import HealthKit

@MainActor
class WeekStepGraphViewModel: BaseIncrementalYLabelGraphViewModel {
    var manager: HealthKitManager
    let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

    init(profileDataSource: ProfileDataSource = .shared) {
        manager = HealthKitManager()
        super.init(profileDataSource: profileDataSource)
    }

    @Published var weekSteps: [GraphValue] = []
    @Published var stepRateYGraphRange: ClosedRange<Int> = 0 ... StepRating.highDefaultStepCount.rawValue
    @Published var stepRatingYGraphValues: [Int] = []

    func fetchStepCount() async {
        let calendar = Calendar.current
        let nowTime = Date()
        let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: nowTime)!
        let startOfDayOneWeekAgo = calendar.startOfDay(for: oneWeekAgo)
        let interval = DateComponents(day: 1)

        do {
            let samples = try await manager.fetchQuery(startOfDay: startOfDayOneWeekAgo, endOfDay: nowTime, interval: interval, sampleType: stepType)
            try assignTargetDateSteps(samples)
        } catch {
            setError(withMessage: "歩数の取得処理に失敗しました", error: error)
        }
    }

    private func assignTargetDateSteps(_ steps: [HKQuantitySample]) throws {
        do {
            if !steps.isEmpty {
                let (dateRange, groupedSteps) = try calculateDateRangeAndGroupedSteps(steps)
                weekSteps = convertToGraphValues(dateRange: dateRange, groupedValues: groupedSteps)
                stepRatingYGraphValues = convertToYGraphLabelValues(dateRange: dateRange, groupedGraphValues: groupedSteps,
                                                                    initialRatingValues: [0] + HydrationRating.allCases.map(\.rawValue))
                stepRateYGraphRange = convertToStepRateRange()
            }
        } catch {
            throw error
        }
    }

    private func calculateDateRangeAndGroupedSteps(_ steps: [HKQuantitySample]) throws -> ([Date], [Date: [StepSample]]) {
        do {
            let dateRange = try calculateDateRange()
            let calendar = Calendar.current
            let groupedSteps = Dictionary(grouping: steps) { value -> Date in
                calendar.startOfDay(for: value.startDate)
            }
            let stepsInHour = dateRange.reduce(into: [Date: [StepSample]]()) { result, date in
                result[date] = groupedSteps[date]?.map(StepSample.init) ?? []
            }
            return (dateRange, stepsInHour)
        } catch {
            throw error
        }
    }

    private func convertToStepRateRange() -> ClosedRange<Int> {
        let stepRatingMax = stepRatingYGraphValues.max() ?? StepRating.highDefaultStepCount.rawValue
        return noEntryValueForSpecificTime ... stepRatingMax
    }
}
