//
//  BaseReminderScheduler.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/11.
//

import Foundation
import UserNotifications

class BaseReminderScheduler: BaseViewModel {
    @Published var isReminderActive = true
    @Published var selectedHour = 0
    @Published var selectedMinute = 0
    @Published var scheduledTimeSelections: [TimeSelection] = [TimeSelection()]
    @Published var selectedTab: Reminder = .repeating

    func validateInputs() -> Bool {
        if selectedTab == .repeating {
            if selectedHour == 0, selectedMinute == 0 {
                setError(withMessage: "0時間0分は設定しないで下さい")
                return false
            }
        } else if selectedTab == .scheduled {
            if scheduledTimeSelections.isEmpty {
                setError(withMessage: "１件以上は時刻を設定して下さい")
                return false
            }
        }
        return true
    }

    func sendNotification(for reminder: BaseReminderProtocol, type: ReminderType) async -> Bool {
        let reminderNotificationData = dataForReminderType(type: type)
        let center = UNUserNotificationCenter.current()

        let checkStatus = await center.notificationSettings()
        if checkStatus.authorizationStatus != .authorized {
            return true
        }
        let requests = await center.pendingNotificationRequests()
        let hasPhysicalConditionReminder = requests.contains { $0.identifier == reminderNotificationData.reminderName }

        if hasPhysicalConditionReminder {
            center.removePendingNotificationRequests(withIdentifiers: [reminderNotificationData.reminderName])
        }

        if !reminder.isActive {
            return true
        }

        let content = UNMutableNotificationContent()
        content.title = reminderNotificationData.notificationTitle
        content.body = reminderNotificationData.notificationBody
        content.sound = UNNotificationSound.default

        do {
            if reminder.type == .repeating {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(reminder.interval!), repeats: true)
                let request = UNNotificationRequest(identifier: reminderNotificationData.reminderName, content: content, trigger: trigger)
                try await center.add(request)
            } else if reminder.type == .scheduled {
                for time in reminder.scheduledTimes! {
                    let hour = Calendar.current.component(.hour, from: time)
                    let minute = Calendar.current.component(.minute, from: time)
                    var dateComponents = DateComponents()
                    dateComponents.hour = hour
                    dateComponents.minute = minute
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let request = UNNotificationRequest(identifier: reminderNotificationData.reminderName, content: content, trigger: trigger)
                    try await center.add(request)
                }
            }
            return true
        } catch {
            setError(withMessage: "通知の許可リクエストまたは通知スケジュールに失敗しました")
            return false
        }
    }

    private func dataForReminderType(type: ReminderType) -> ReminderNotificationData {
        var reminderName = ""
        var notificationTitle = ""
        var notificationBody = ""
        switch type {
        case .physicalCondition:
            reminderName = ReminderType.physicalCondition.rawValue
            notificationTitle = "体調の記録をつけるお時間です"
            notificationBody = "通知をタップして体調の記録をしませんか？"
        case .hydration:
            reminderName = ReminderType.hydration.rawValue
            notificationTitle = "水分摂取のお時間です"
            notificationBody = "通知をタップして水分の記録をしませんか？"
        }
        return ReminderNotificationData(reminderName: reminderName,
                                        notificationTitle: notificationTitle,
                                        notificationBody: notificationBody)
    }
}
