//
//  StandHourChartYModifier.swift
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
                AxisMarks(position: .leading, values: ratingValues) { value in
                    if let rawValue = value.as(Int.self), let rating = StandingHourRating(rawValue: rawValue) {
                        AxisValueLabel {
                            Text(rating.label)
                        }
                    }
                }
                AxisMarks(
                    values: Array(stpeRateRange)
                ) {
                    AxisGridLine()
                }
            }
    }
}
