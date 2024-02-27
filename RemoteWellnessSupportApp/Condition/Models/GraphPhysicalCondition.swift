//
//  GraphPhysicalCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/25.
//

import Foundation

struct GraphPhysicalCondition: Identifiable {
    var id = UUID()
    var timeZone: Date
    var rateAverage: Int
}
