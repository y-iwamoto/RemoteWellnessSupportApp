//
//  ReminderSettingView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import SwiftUI

struct ReminderSettingView: View {
    @StateObject var viewModel = ReminderSettingViewModel()
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var router: SettingScreenNavigationRouter

    var body: some View {
        VStack {
            Text("リマインダー変更")

            CustomSection {
                Text("通知設定")
                    .font(.headline)
                    .modifier(MaxWidthLeadingAlignmentPaddingModifier())

                Text("通知の状態: \(viewModel.statusText)")
                    .modifier(MaxWidthLeadingAlignmentPaddingModifier())

                Button("設定アプリで変更する") {
                    openAppSettings()
                }
                .modifier(MaxWidthLeadingAlignmentPaddingModifier())
            }

            ReminderSection(title: "体調通知", reminder: viewModel.physicalConditionReminder) {
                if let reminder = viewModel.physicalConditionReminder {
                    router.items.append(SettingScreenNavigationItem.physicalConditionReminderEdit(reminder: reminder))
                }
            }

            ReminderSection(title: "水分摂取通知", reminder: viewModel.hydrationReminder) {
                if let reminder = viewModel.hydrationReminder {
                    router.items.append(SettingScreenNavigationItem.hydrationReminderEdit(reminder: reminder))
                }
            }
            Spacer()
        }
        .onAppear {
            Task {
                await viewModel.checkNotificationStatus()
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task {
                    await viewModel.checkNotificationStatus()
                }
            }
        }
    }

    private func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        UIApplication.shared.open(settingsUrl)
    }

    struct MaxWidthLeadingAlignmentPaddingModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
        }
    }
}
