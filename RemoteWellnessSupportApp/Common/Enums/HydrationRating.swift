//
//  HydrationRating.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Foundation

enum HydrationRating: Int, CaseIterable, SelectableItem {
    var id: Self { self }

    case teaCup = 250
    case glass = 500
    case mugCup = 750

    static let initialHydrationRatingValues = [0] + HydrationRating.allCases.map(\.rawValue)

    var label: String {
        switch self {
        case .teaCup:
            "250ml"
        case .glass:
            "500ml"
        case .mugCup:
            "750ml"
        }
    }

    var imageName: String {
        switch self {
        case .teaCup:
            "cup.and.saucer.fill"
        case .glass:
            "wineglass.fill"
        case .mugCup:
            "mug.fill"
        }
    }
}
