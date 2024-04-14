//
//  StepRating.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import Foundation

enum StepRating: Int {
    case lowDefaultStepCount = 100
    case mediumDefaultStepCount = 200
    case highDefaultStepCount = 300

    static let initialHydrationRatingValues = [0] + HydrationRating.allCases.map(\.rawValue)
}
