//
//  ChartXAxisModifier.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/27.
//

import Charts
import SwiftUI

struct ChartXAxisModifier: ViewModifier {
    let unit: Calendar.Component
    let xAxisFormat: String

    func body(content: Content) -> some View {
        content
            .chartXAxis {
                AxisMarks(values: .stride(by: unit)) { value in
                    if let date = value.as(Date.self) {
                        AxisGridLine()
                        AxisValueLabel("\(date.toString(format: xAxisFormat))", centered: true)
                    }
                }
            }
    }
}
