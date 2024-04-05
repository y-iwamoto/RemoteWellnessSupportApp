//
//  GraphValueChartView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Charts
import SwiftUI

struct GraphValueChartView: View {
    let graphValues: [GraphValue]
    let timeZoneType: TimeZoneType
    let ratingYGraphValues: [Int]
    let graphType: GraphType
    let YRateRange: ClosedRange<Int>

    var body: some View {
        let unit = timeZoneType == .hour ? Calendar.Component.hour : Calendar.Component.day
        let xAxisFormat = timeZoneType == .hour ? GraphDefinition.TimeZone.hour.rawValue : GraphDefinition.TimeZone.date.rawValue
        Chart(graphValues) { graphValue in
            LineMark(x: .value(GraphDefinition.Label.timeZone.rawValue, graphValue.timeZone, unit: unit),
                     y: .value(graphType.label.rawValue, graphValue.rateAverage))
                .interpolationMethod(.catmullRom)
            PointMark(
                x: .value(GraphDefinition.Label.timeZone.rawValue, graphValue.timeZone, unit: unit),
                y: .value(graphType.label.rawValue, graphValue.rateAverage)
            )
        }
        .modifier(ChartXAxisModifier(unit: unit, xAxisFormat: xAxisFormat))
        .modifier(HydrationChartYModifier(hydrationRateRange: YRateRange, ratingValues: ratingYGraphValues))
    }
}
