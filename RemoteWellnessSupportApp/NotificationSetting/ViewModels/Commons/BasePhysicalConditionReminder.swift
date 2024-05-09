//
//  BasePhysicalConditionReminder.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/07.
//

import Foundation
import UserNotifications

class BasePhysicalConditionReminder: BaseViewModel {
    let dataSource: PhysicalConditionReminderDataSource
    @Published var isReminderActive = true
    @Published var selectedHour = 0
    @Published var selectedMinute = 0
    @Published var scheduledTimeSelections: [TimeSelection] = [TimeSelection()]
    @Published var selectedTab: Reminder = .repeating

    init(dataSource: PhysicalConditionReminderDataSource = PhysicalConditionReminderDataSource.shared) {
        self.dataSource = dataSource
    }

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

    func sendNotification(for reminder: PhysicalConditionReminder) async -> Bool {
        let center = UNUserNotificationCenter.current()

        let checkStatus = await center.notificationSettings()
        if checkStatus.authorizationStatus != .authorized {
            return true
        }
        let requests = await center.pendingNotificationRequests()
        let hasPhysicalConditionReminder = requests.contains { $0.identifier == "physicalConditionReminder" }

        if hasPhysicalConditionReminder {
            center.removePendingNotificationRequests(withIdentifiers: ["physicalConditionReminder"])
        }

        if !reminder.isActive {
            return true
        }

        let content = UNMutableNotificationContent()
        content.title = "体調の記録をつけるお時間です"
        content.body = "通知をタップして体調の記録をしませんか？"
        content.sound = UNNotificationSound.default

        do {
            if reminder.type == .repeating {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(reminder.interval!), repeats: true)
                let request = UNNotificationRequest(identifier: "physicalConditionReminder", content: content, trigger: trigger)
                try await center.add(request)
            } else if reminder.type == .scheduled {
                for time in reminder.scheduledTimes! {
                    let hour = Calendar.current.component(.hour, from: time)
                    let minute = Calendar.current.component(.minute, from: time)
                    var dateComponents = DateComponents()
                    dateComponents.hour = hour
                    dateComponents.minute = minute
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let request = UNNotificationRequest(identifier: "physicalConditionReminder", content: content, trigger: trigger)
                    try await center.add(request)
                }
            }
            return true
        } catch {
            setError(withMessage: "通知の許可リクエストまたは通知スケジュールに失敗しました")
            return false
        }
    }
}
