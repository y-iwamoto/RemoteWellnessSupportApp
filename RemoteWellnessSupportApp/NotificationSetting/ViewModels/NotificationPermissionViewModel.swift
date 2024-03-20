//
//  NotificationPermissionViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/14.
//

import Foundation
import UserNotifications

class NotificationPermissionViewModel: ObservableObject {
    @Published var isNotificationPermissionGranted = false
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    func scheduleNotification() async {
        let center = UNUserNotificationCenter.current()
        if await checkAuthorizeNotificationSetting(center: center) {
            await notificationPermissionGranted()
            return
        }
        do {
            if try await center.requestAuthorization(options: [.alert, .sound]) {
                await notificationPermissionGranted()
            }
        } catch {
            await setError(withMessage: "通知の許可リクエストまたは通知スケジュールに失敗しました")
        }
    }

    private func checkAuthorizeNotificationSetting(center: UNUserNotificationCenter) async -> Bool {
        let checkStatus = await center.notificationSettings()
        if checkStatus.authorizationStatus == .authorized {
            return true
        }
        return false
    }

    @MainActor private func notificationPermissionGranted() async {
        isNotificationPermissionGranted = true
    }

    @MainActor private func setError(withMessage message: String) {
        isErrorAlert = true
        errorMessage = message
    }
}
