//
//  PhysicalConditionChartYModifier.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/27.
//

import Charts
import SwiftUI

struct PhysicalConditionChartYModifier: ViewModifier {
    let physicalConditionRateRange = 0 ... 5
    let ratingValues: [Int]

    func body(content: Content) -> some View {
        content
            .chartYScale(domain: physicalConditionRateRange)
            .chartYAxis {
                AxisMarks(position: .leading, values: ratingValues) { value in
                    if let rawValue = value.as(Int.self), let rating = PhysicalConditionRating(rawValue: rawValue) {
                        AxisValueLabel {
                            Image(systemName: rating.imageName)
                        }
                    }
                }
                AxisMarks(
                    values: Array(physicalConditionRateRange)
                ) {
                    AxisGridLine()
                }
            }
    }
}
