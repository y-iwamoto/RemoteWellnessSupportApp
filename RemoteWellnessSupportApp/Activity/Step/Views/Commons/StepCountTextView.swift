//
//  StepCountTextView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import HealthKit
import SwiftUI

struct StepCountTextView: View {
    var stepItem: HKQuantitySample

    var body: some View {
        Text("\(Int(stepItem.quantity.doubleValue(for: HKUnit.count())))歩")
    }
}
