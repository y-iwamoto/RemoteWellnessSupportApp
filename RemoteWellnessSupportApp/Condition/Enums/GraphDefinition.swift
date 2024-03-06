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
    }

    enum TimeZone: String {
        case hour = "H"
        case date = "MM/dd"
    }
}
