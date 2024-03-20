//
//  PhysicalConditionReminderViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import Foundation
import UserNotifications

class PhysicalConditionReminderViewModel: ObservableObject {
    private let dataSource: PhysicalConditionReminderDataSource
    @Published var isReminderActive = true
    @Published var selectedHour = 0
    @Published var selectedMinute = 0
    @Published var scheduledTimeSelections: [TimeSelection] = [TimeSelection()]
    @Published var selectedTab: ReminderTab = .repeating
    @Published var isErrorAlert = false
    @Published var errorMessage = ""
    
    
    init(dataSource: PhysicalConditionReminderDataSource = PhysicalConditionReminderDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func savePhysicalConditionReminderSetteing() async -> Bool  {
        guard await validateInputs() else {
            return false
        }
        
        let physicalConditionReminder = createPhysicalConditionReminder()

        guard await insertPhysicalConditionReminderIntoDataSource(physicalConditionReminder) else {
            return false
        }

        return await sendNotification(for: physicalConditionReminder)
    }
    
    private func createPhysicalConditionReminder() -> PhysicalConditionReminder {
        var physicalConditionReminder: PhysicalConditionReminder
        let sendsToiOS = isReminderActive ? true : false
        let sendsTowatchOS = false
        let interval = selectedHour * 3600 + selectedMinute * 60
        
        let scheduledTimes = scheduledTimeSelections.map { $0.selectedTime }.sorted()
        
        if !isReminderActive {
            physicalConditionReminder = PhysicalConditionReminder(isActive: isReminderActive, sendsToiOS: sendsToiOS, sendsTowatchOS: sendsTowatchOS)
        } else if selectedTab == .repeating {
            physicalConditionReminder = PhysicalConditionReminder(isActive: isReminderActive, sendsToiOS: sendsToiOS, sendsTowatchOS: sendsTowatchOS, type: .repeating, interval: interval)
        } else {
            physicalConditionReminder = PhysicalConditionReminder(isActive: isReminderActive, sendsToiOS: sendsToiOS, sendsTowatchOS: sendsTowatchOS, type: .scheduled, scheduledTimes: scheduledTimes)
        }
        
        return physicalConditionReminder
    }
    
    @MainActor private func insertPhysicalConditionReminderIntoDataSource(_ reminder: PhysicalConditionReminder) -> Bool {
        do {
            try self.dataSource.insertPhysicalConditionReminder(physicalConditionReminder: reminder)
            return true
        } catch {
            setError(withMessage: "通知設定の登録に失敗しました")
            return false
        }
    }
    
    @MainActor private func sendNotification(for reminder: PhysicalConditionReminder) async -> Bool {
        let center = UNUserNotificationCenter.current()

        let checkStatus = await center.notificationSettings()
        if checkStatus.authorizationStatus != .authorized {
            return true
        }
        
        let content = UNMutableNotificationContent()
        content.title = "体調の記録をつけるお時間です"
        content.body = "通知をタップして体調の記録をしませんか？"
        content.sound = UNNotificationSound.default

        do {
            if reminder.type == .repeating {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(reminder.interval!), repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                try await center.add(request)
            } else if reminder.type == .scheduled {
                for time in reminder.scheduledTimes! {
                    let hour = Calendar.current.component(.hour, from: time)
                    let minute = Calendar.current.component(.minute, from: time)
                    var dateComponents = DateComponents()
                    dateComponents.hour = hour
                    dateComponents.minute = minute
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    try await center.add(request)
                }
            }
            return true
        } catch {
            setError(withMessage: "通知の許可リクエストまたは通知スケジュールに失敗しました")
            return false
        }
        
    }

    @MainActor private func validateInputs() -> Bool {
        if selectedTab == .repeating {
            if selectedHour == 0 &&  selectedMinute == 0 {
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

    private func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
    
}
