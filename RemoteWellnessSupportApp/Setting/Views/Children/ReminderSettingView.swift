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

            CustomSection {
                Text("体調通知")
                    .font(.headline)
                    .modifier(MaxWidthLeadingAlignmentPaddingModifier())

                if let physicalConditionReminder = viewModel.physicalConditionReminder {
                    HStack {
                        reminderText(for: physicalConditionReminder)
                        Spacer()
                        Button(action: {
                            router.items.append(SettingScreenNavigationItem.physicalConditionReminderEdit(reminder: physicalConditionReminder))
                        }, label: {
                            Image(systemName: "square.and.pencil")
                        })
                    }
                    .padding(10)

                } else {
                    Text("通知設定なし")
                        .modifier(MaxWidthLeadingAlignmentPaddingModifier())
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

    private struct MaxWidthLeadingAlignmentPaddingModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
        }
    }

    @ViewBuilder
    private func reminderText(for reminder: PhysicalConditionReminder) -> some View {
        if !reminder.isActive {
            Text("通知設定OFF")
        } else if reminder.type == .scheduled, let scheduledTimes = reminder.scheduledTimes {
            ForEach(scheduledTimes, id: \.self) { scheduledTime in
                Text("\(scheduledTime.toString(format: "HH:mm"))")
            }
        } else if reminder.type == .repeating {
            Text("\(viewModel.convertedIntervalText)")
        }
    }
}
