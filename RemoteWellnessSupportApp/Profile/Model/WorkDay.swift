//
//  WorkDay.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import Foundation

enum WorkDay: Int, CaseIterable, Codable {
    case monday = 0
    case tuesday = 1
    case wednesday = 2
    case thursday = 3
    case friday = 4
    case saturday = 5
    case sunday = 6

    var labelName: String {
        switch self {
        case .monday:
            "月"
        case .tuesday:
            "火"
        case .wednesday:
            "水"
        case .thursday:
            "木"
        case .friday:
            "金"
        case .saturday:
            "土"
        case .sunday:
            "日"
        }
    }
}
