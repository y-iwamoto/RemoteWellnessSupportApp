//
//  HealthKitManager.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/10.
//

import Foundation
import HealthKit

class HealthKitManager {
    private var healthStore: HKHealthStore
    init() {
        healthStore = HKHealthStore()
    }

    func authorizeHealthKit(toShare: Set<HKSampleType>,
                            read: Set<HKObjectType>) async throws {
        try await healthStore.requestAuthorization(toShare: toShare, read: read)
    }

    func fetchQuery(startOfDay: Date, endOfDay: Date, interval: DateComponents, sampleType: HKQuantityType) async throws -> [HKQuantitySample] {
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: predicate,
                                                options: .cumulativeSum, anchorDate: startOfDay, intervalComponents: interval)

        return try await withCheckedThrowingContinuation { continuation in
            query.initialResultsHandler = { _, results, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let results else {
                    continuation.resume(throwing: HealthKitError.noResults(description: "NoResultsError"))
                    return
                }
                var samples: [HKQuantitySample] = []
                results.enumerateStatistics(from: startOfDay, to: endOfDay) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let date = statistics.startDate
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        let sample = HKQuantitySample(type: sampleType, quantity:
                            HKQuantity(unit: HKUnit.count(), doubleValue: steps),
                            start: date, end: date.addingTimeInterval(3600))
                        samples.append(sample)
                    }
                }
                continuation.resume(returning: samples)
            }
            healthStore.execute(query)
        }
    }

    func fetchAppleStandHourData(startOfDay: Date, endOfDay: Date) async throws -> [HKCategorySample] {
        let standHourType = HKObjectType.categoryType(forIdentifier: .appleStandHour)!
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(sampleType: standHourType, predicate: predicate,
                                      limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let samples = samples as? [HKCategorySample] else {
                    continuation.resume(throwing: HealthKitError.noResults(description: "NoResultsError"))
                    return
                }

                continuation.resume(returning: samples)
            }

            healthStore.execute(query)
        }
    }
}
