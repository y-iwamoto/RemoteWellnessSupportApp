//
//  PhysicalConditionChartView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/26.
//

import Charts
import SwiftUI

struct PhysicalConditionChartView: View {
    let physicalConditions: [GraphValue]
    let timeZoneType: TimeZoneType
    let ratingValues = PhysicalConditionRating.allCases.map(\.rawValue)

    var body: some View {
        let unit = timeZoneType == .hour ? Calendar.Component.hour : Calendar.Component.day
        let xAxisFormat = timeZoneType == .hour ? GraphDefinition.TimeZone.hour.rawValue : GraphDefinition.TimeZone.date.rawValue
        Chart(physicalConditions) { physicalCondition in
            LineMark(x: .value(GraphDefinition.Label.timeZone.rawValue, physicalCondition.timeZone, unit: unit),
                     y: .value(GraphDefinition.Label.physicalCondition.rawValue, physicalCondition.rateAverage))
                .interpolationMethod(.catmullRom)
            PointMark(
                x: .value(GraphDefinition.Label.timeZone.rawValue, physicalCondition.timeZone, unit: unit),
                y: .value(GraphDefinition.Label.physicalCondition.rawValue, physicalCondition.rateAverage)
            )
        }
        .modifier(ChartXAxisModifier(unit: unit, xAxisFormat: xAxisFormat))
        .modifier(PhysicalConditionChartYModifier(ratingValues: ratingValues))
    }
}
