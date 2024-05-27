//
//  PomodoroTimerViewModel+Notification.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/16.
//

import Foundation
import UserNotifications

extension PomodoroTimerViewModel {
    func sendMainTimerEndNotification() async {
        guard isReminderActive else {
            return
        }
        await sendPomodoroNotification(type: .mainTimer, interval: PomodoroTimerViewModel.MaxTimer)
    }

    func sendBreakTimerEndNotification() async {
        guard isReminderActive else {
            return
        }
        await sendPomodoroNotification(type: .breakTimer, interval: PomodoroTimerViewModel.BreakTime)
    }

    func cancelCurrentNotification(type: PomodoroReminderType) {
        let reminderNotificationData = dataForPomodoroReminderType(type: type)
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [reminderNotificationData.reminderName])
    }

    func resumeNotification() async {
        let interval = secondsLeft
        let type = timerMode == .breakMode ? PomodoroReminderType.breakTimer : PomodoroReminderType.mainTimer
        await sendPomodoroNotification(type: type, interval: interval)
    }

    private func sendPomodoroNotification(type: PomodoroReminderType, interval: Int) async {
        let reminderNotificationData = dataForPomodoroReminderType(type: type)
        let center = UNUserNotificationCenter.current()
        let checkStatus = await center.notificationSettings()
        if checkStatus.authorizationStatus != .authorized {
            return
        }
        center.removePendingNotificationRequests(withIdentifiers: [reminderNotificationData.reminderName])

        let content = UNMutableNotificationContent()
        content.title = reminderNotificationData.notificationTitle
        content.body = reminderNotificationData.notificationBody
        content.sound = UNNotificationSound.default

        do {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: false)
            let request = UNNotificationRequest(identifier: reminderNotificationData.reminderName, content: content, trigger: trigger)
            try await center.add(request)
        } catch {
            setError(withMessage: "通知の許可リクエストまたは通知スケジュールに失敗しました")
        }
    }

    private func dataForPomodoroReminderType(type: PomodoroReminderType) -> ReminderNotificationData {
        var reminderName = ""
        var notificationTitle = ""
        var notificationBody = ""
        switch type {
        case .mainTimer:
            reminderName = PomodoroReminderType.mainTimer.rawValue
            notificationTitle = "\(formatPomodoroTime(PomodoroTimerViewModel.MaxTimer))経ちました"
            notificationBody = "休憩に入りましょう"
        case .breakTimer:
            reminderName = PomodoroReminderType.breakTimer.rawValue
            notificationTitle = "\(formatPomodoroTime(PomodoroTimerViewModel.BreakTime))経ちました"
            notificationBody = "業務に戻りましょう"
        }
        return ReminderNotificationData(reminderName: reminderName,
                                        notificationTitle: notificationTitle,
                                        notificationBody: notificationBody)
    }
}
