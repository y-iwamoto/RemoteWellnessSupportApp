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
        case .profileSetting:
            ProfileSettingView()
        case .reminderEditList:
            ReminderSettingView()
        case let .nicknameEditInput(profile):
            NicknameEditInputView(profile: profile)
        case let .workDaySelectEdit(profile: profile):
            WorkDaySelectEditView(profile: profile)
        case let .workTimeEditInput(profile: profile):
            WorkTimeEditInputView(profile: profile)
        case let .restTimeEditInput(profile: profile):
            RestTimeEditInputView(profile: profile)
        case let .goalSettingEditInput(profile: profile):
            GoalSettingEditInputView(profile: profile)
        case let .physicalConditionReminderEdit(reminder: reminder):
            PhysicalConditionReminderEditView(reminder: reminder)
        }
    }
}

#Preview {
    SettingScreen()
}
