//
//  PhysicalConditionRating.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/15.
//

import Foundation

enum PhysicalConditionRating: Int, CaseIterable, SelectableItem {
    var id: Self { self }

    case excellent = 0
    case good = 1
    case soso = 2
    case fair = 3
    case poor = 4

    var label: String {
        switch self {
        case .excellent:
            return "最高"
        case .good:
            return "良い"
        case .soso:
            return "普通"
        case .fair:
            return "悪い"
        case .poor:
            return "最悪"
        }
    }

    var imageName: String {
        switch self {
        case .excellent:
            return "star.fill"
        case .good:
            return "star.lefthalf.fill"
        case .soso:
            return "star.leadinghalf.fill"
        case .fair:
            return "star"
        case .poor:
            return "star.slash"
        }
    }
}
