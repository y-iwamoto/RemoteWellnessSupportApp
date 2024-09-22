//
//  SandHourChartYModifier.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/09/21.
//

import Charts
import SwiftUI

struct StandHourChartYModifier: ViewModifier {
    let stpeRateRange = 0 ... 1
    let ratingValues: [Int]

    func body(content: Content) -> some View {
        content
            .chartYScale(domain: stpeRateRange)
            .chartYAxis {
                labelAxisMarks(for: ratingValues)
                AxisMarks(
                    values: Array(stpeRateRange)
                ) {
                    AxisGridLine()
                }
            }
    }

    private func labelAxisMarks(for values: [Int]) -> some AxisContent {
        AxisMarks(position: .leading, values: values) { value in
            if let rawValue = value.as(Int.self), let rating = StandingHourRating(rawValue: rawValue) {
                AxisValueLabel {
                    Text(rating.label)
                }
            }
        }
    }
}
