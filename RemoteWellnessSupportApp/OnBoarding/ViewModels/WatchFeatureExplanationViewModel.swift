//
//  WatchFeatureExplanationViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/06.
//

import Foundation
import SwiftUI

class WatchFeatureExplanationViewModel: ObservableObject {
    @AppStorage(Const.AppStatus.hasCompletedOnboarding) var hasCompletedOnboarding = false

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }
}
