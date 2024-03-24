//
//  RestTimePeriodSection.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import Foundation

struct RestTimePeriodSection: TimeSelectable {
    var fromTime: TimeSelection
    var toTime: TimeSelection
    var id = UUID()
}
