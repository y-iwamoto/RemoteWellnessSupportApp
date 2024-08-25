//
//  RootView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/24.
//

import SwiftUI

struct RootView: View {
    @AppStorage(Const.AppStatus.hasCompletedOnboarding) var hasCompletedOnboarding: Bool = Const.AppDefaults.hasCompletedOnboarding
    @AppStorage(Const.AppStatus.hasCompletedProfileRegister) var hasCompletedProfileRegister
        = Const.AppDefaults.hasCompletedProfileRegister

    var body: some View {
        if hasCompletedProfileRegister {
            MainView()
        } else if hasCompletedOnboarding {
            ProfileScreen()
        } else {
            OnboardingScreenView()
        }
    }
}

#Preview {
    RootView()
}
