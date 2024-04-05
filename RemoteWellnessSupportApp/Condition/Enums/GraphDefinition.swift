//
//  GraphDefinition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/27.
//

import Foundation

enum GraphDefinition {
    enum Label: String {
        case timeZone = "時間"
        case physicalCondition = "体調"
        case hydration = "水分摂取量"
        case step = "アクティビティ"
        case review = "振り返り"
    }

    enum TimeZone: String {
        case hour = "H"
        case date = "EEEE"
    }
}

enum GraphType: String {
    case hydration
    case physicalCondition
    case step
    case review

    var label: GraphDefinition.Label {
        switch self {
        case .hydration:
            .hydration
        case .physicalCondition:
            .physicalCondition
        case .step:
            .step
        case .review:
            .review
        }
    }
}
