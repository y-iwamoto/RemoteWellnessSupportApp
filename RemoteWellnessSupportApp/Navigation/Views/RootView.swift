//
//  RootView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/24.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    var body: some View {
        if hasCompletedOnboarding {
            MainView()
        } else {
            OnboardingScreenView()
        }
    }
}

#Preview {
    RootView()
}
