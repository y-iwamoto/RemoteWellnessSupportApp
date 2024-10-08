//
//  ReminderSection.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/12.
//

import SwiftUI

struct ReminderSection: View {
    @Binding var isNotificationEnabled: Bool
    let title: String
    let reminder: BaseReminderProtocol?
    let action: () -> Void

    var body: some View {
        CustomSection {
            Text(title)
                .font(.headline)
                .modifier(ReminderSettingView.MaxWidthLeadingAlignmentPaddingModifier())

            if let reminder, isNotificationEnabled {
                HStack {
                    reminderText(for: reminder)
                    Spacer()
                    Button(action: action, label: {
                        Image(systemName: "square.and.pencil")
                    })
                }
                .padding(10)
            } else if !isNotificationEnabled {
                Text("通知不許可")
                    .modifier(ReminderSettingView.MaxWidthLeadingAlignmentPaddingModifier())

            } else {
                Text("通知設定なし")
                    .modifier(ReminderSettingView.MaxWidthLeadingAlignmentPaddingModifier())
            }
        }
    }

    @ViewBuilder
    private func reminderText(for reminder: BaseReminderProtocol) -> some View {
        if !reminder.isActive {
            Text("通知設定OFF")
        } else if reminder.type == .scheduled, let scheduledTimes = reminder.scheduledTimes {
            ForEach(scheduledTimes, id: \.self) { scheduledTime in
                Text("\(scheduledTime.toString(format: "HH:mm"))")
            }
        } else if reminder.type == .repeating {
            Text(convertedIntervalText(interval: reminder.interval))
        }
    }

    private func convertedIntervalText(interval: Int?) -> String {
        let intervalInSeconds = interval ?? 0
        let hours = intervalInSeconds / 3600
        let minutes = (intervalInSeconds % 3600) / 60
        return "\(hours)時間\(minutes)分毎"
    }
}
