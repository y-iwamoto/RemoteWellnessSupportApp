//
//  HydrationChartYModifier.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Charts
import SwiftUI

struct HydrationChartYModifier: ViewModifier {
    let hydrationRateRange: ClosedRange<Int>
    let ratingValues: [Int]

    func body(content: Content) -> some View {
        content
            .chartYScale(domain: hydrationRateRange)
            .chartYAxis {
                AxisMarks(position: .leading, values: ratingValues) { value in
                    if let rawValue = value.as(Int.self) {
                        AxisValueLabel {
                            Text("\(rawValue)")
                        }
                    }
                }
                AxisMarks(
                    values: Array(stride(from: hydrationRateRange.lowerBound, through: hydrationRateRange.upperBound, by: ratingValues[1]))
                ) {
                    AxisGridLine()
                }
            }
    }
}
