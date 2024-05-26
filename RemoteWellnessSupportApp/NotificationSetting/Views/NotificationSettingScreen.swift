//
//  NotificationSettingScreen.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import SwiftUI

struct NotificationSettingScreen: View {
    @StateObject var router = NotificationSettingNavigationRouter()
    var body: some View {
        NavigationStack(path: $router.items) {
            NotificationPermissionView()
                .navigationDestination(for: NotificationSettingNavigationItem.self) { destination in
                    switch destination {
                    case .notificationPermission:
                        NotificationPermissionView()
                    case .physicalConditionReminder:
                        PhysicalConditionReminderView()
                    case .hydrationReminder:
                        HydrationReminderView()
                    case .pomodoroReminder:
                        PomodoroReminderView()
                    case .notificationSettingEnd:
                        NotificationSettingEndView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    NotificationSettingScreen()
}
