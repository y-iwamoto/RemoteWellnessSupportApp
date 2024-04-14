//
//  StepSample.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/11.
//

import Foundation
import HealthKit

struct StepSample: GraphColumnHaving {
    let entryDate: Date
    let rating: Int

    init(sample: HKQuantitySample) {
        entryDate = sample.startDate
        rating = Int(sample.quantity.doubleValue(for: HKUnit.count()))
    }
}
