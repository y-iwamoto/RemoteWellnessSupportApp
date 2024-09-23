//
//  StandingHourRating.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/09/21.
//

import Foundation

enum StandingHourRating: Int {
    case sedentary = 0
    case stoodUp = 1

    var labelShort: String {
        switch self {
        case .sedentary:
            "座った\r\nまま"
        case .stoodUp:
            "立ち時\r\n間あり"
        }
    }

    var label: String {
        switch self {
        case .sedentary:
            "座ったまま"
        case .stoodUp:
            "立った時間あり"
        }
    }
}
