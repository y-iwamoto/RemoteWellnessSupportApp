//
//  SettingScreen.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import SwiftUI

struct SettingScreen: View {
    @StateObject var router = SettingScreenNavigationRouter()

    var body: some View {
        NavigationStack(path: $router.items) {
            SettingList()
                .navigationDestination(for: SettingScreenNavigationItem.self, destination: navigationDestinationBuilder)
        }
        .environmentObject(router)
    }

    @ViewBuilder
    private func navigationDestinationBuilder(item: SettingScreenNavigationItem) -> some View {
        switch item {
        case .profileEditList:
            ProfileEditView()
        case .reminderEditList:
            ReminderEditView()
        }
    }
}

#Preview {
    SettingScreen()
}
