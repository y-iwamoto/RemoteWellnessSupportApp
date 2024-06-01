//
//  RootView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/24.
//

import SwiftUI

struct RootView: View {
    @AppStorage(Const.AppStatus.hasCompletedOnboarding) var hasCompletedOnboarding: Bool = Const.AppDefaults.hasCompletedOnboarding
    @AppStorage(Const.AppStatus.hasCompletedNotificationSetting) var hasCompletedNotificationSetting
        = Const.AppDefaults.hasCompletedNotificationSetting
    @AppStorage(Const.AppStatus.hasCompletedProfileRegister) var hasCompletedProfileRegister
        = Const.AppDefaults.hasCompletedProfileRegister

    var body: some View {
        if hasCompletedNotificationSetting {
            MainView()
        } else if hasCompletedProfileRegister {
            NotificationSettingScreen()
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
