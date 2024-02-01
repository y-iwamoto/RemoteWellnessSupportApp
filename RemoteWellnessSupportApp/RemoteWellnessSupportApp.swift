//
//  RemoteWellnessSupportApp.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/24.
//

import SwiftUI

@main
struct RemoteWellnessSupportApp: App {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                ContentView()
            } else {
                OnboardingScreenView()
            }
        }
    }
}
