//
//  StandStatusGraphViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/09.
//

import Foundation
import HealthKit

@MainActor
final class StandStatusGraphViewModel: BaseIncrementalYLabelGraphViewModel {
    var manager: HealthKitManager
    let calendar: Calendar

    init(targetDate: Date = Date()) {
        manager = HealthKitManager()
        calendar = Calendar.current
        super.init(targetDate: targetDate)
    }

    @Published var targetDateStandStatus: [GraphValue] = []
    @Published var standStatusRateYGraphRange: ClosedRange<Int> = 0 ... StepRating.highDefaultStepCount.rawValue
    @Published var standStatusRatingYGraphValues: [Int] = []

    func fetchStandHour() async {
        let startOfDay = calendar.startOfDay(for: targetDate)
        do {
            let samples = try await manager.fetchAppleStandHourData(startOfDay: startOfDay, endOfDay: targetDate)
            if !samples.isEmpty {
                let (hoursRange, groupedSteps) = try calculateDateRangeAndGroupedStandStatus(samples)
                targetDateStandStatus = convertToGraphValues(dateRange: hoursRange, groupedValues: groupedSteps)
                standStatusRatingYGraphValues = StandStatus.allCases.map(\.rawValue)
                standStatusRateYGraphRange = convertToStandStatusRateRange()
            }
        } catch {
            setError(withMessage: "立ち時間の取得処理に失敗しました", error: error)
        }
    }

    private func calculateDateRangeAndGroupedStandStatus(_ standSamples: [HKCategorySample]) throws -> ([Date], [Date: [StandStatusSample]]) {
        let hoursRange = try calculateWorkHoursRange()

        let currentDate = targetDate
        let dates = hoursRange.compactMap { hour -> Date? in
            calendar.date(bySettingHour: hour, minute: 0, second: 0, of: currentDate)
        }

        let groupedStatus = Dictionary(grouping: standSamples) { step -> Date in
            let hour = calendar.component(.hour, from: step.startDate)
            let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: currentDate) ?? currentDate
            return date
        }

        let conditionsInHour = dates.reduce(into: [Date: [StandStatusSample]]()) { result, date in
            result[date] = groupedStatus[date]?.map { sample in
                StandStatusSample(entryDate: date, rating: sample.value)
            } ?? []
        }
        return (dates, conditionsInHour)
    }

    private func convertToStandStatusRateRange() -> ClosedRange<Int> {
        let standStatusRatingMax = StandStatus.stood.rawValue
        return noEntryValueForSpecificTime ... standStatusRatingMax
    }
}
