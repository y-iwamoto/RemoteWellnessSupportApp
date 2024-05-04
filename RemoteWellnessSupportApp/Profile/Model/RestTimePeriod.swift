//
//  RestTimePeriod.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import Foundation

struct RestTimePeriod: Codable, Hashable {
    var id = UUID()
    var fromTime: Date
    var toTime: Date
}
