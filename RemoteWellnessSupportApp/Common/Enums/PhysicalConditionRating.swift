//
//  PhysicalConditionRating.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/15.
//

import Foundation

enum PhysicalConditionRating: Int, CaseIterable, SelectableItem {
    var id: Self { self }

    case excellent = 5
    case good = 4
    case soso = 3
    case fair = 2
    case poor = 1

    var label: String {
        switch self {
        case .excellent:
            "最高"
        case .good:
            "良い"
        case .soso:
            "普通"
        case .fair:
            "悪い"
        case .poor:
            "最悪"
        }
    }

    var imageName: String {
        switch self {
        case .excellent:
            "star.fill"
        case .good:
            "star.lefthalf.fill"
        case .soso:
            "star.leadinghalf.fill"
        case .fair:
            "star"
        case .poor:
            "star.slash"
        }
    }
}
