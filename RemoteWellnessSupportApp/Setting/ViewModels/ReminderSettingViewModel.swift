//
//  ReminderSettingViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/05.
//

import Foundation
import UserNotifications

@MainActor
class ReminderSettingViewModel: BaseViewModel {
    private let physicalConditionReminderDataSource: PhysicalConditionReminderDataSource
    private let hydrationReminderDataSource: HydrationReminderDataSource
    @Published var isNotificationEnabled = false
    @Published var physicalConditionReminder: PhysicalConditionReminder?
    @Published var hydrationReminder: HydrationReminder?

    var convertedIntervalText: String {
        let intervalInSeconds = physicalConditionReminder?.interval ?? 0
        let hours = intervalInSeconds / 3600
        let minutes = (intervalInSeconds % 3600) / 60
        return "\(hours)時間\(minutes)分毎"
    }

    var statusText: String {
        isNotificationEnabled ? "許可" : "不許可"
    }

    init(physicalConditionReminderDataSource: PhysicalConditionReminderDataSource = PhysicalConditionReminderDataSource.shared,
         hydrationReminderDataSource: HydrationReminderDataSource = HydrationReminderDataSource.shared) {
        self.physicalConditionReminderDataSource = physicalConditionReminderDataSource
        self.hydrationReminderDataSource = hydrationReminderDataSource
        super.init()
        fetchPhysicalConditionReminder()
        fetchHydrationReminder()
    }

    func fetchPhysicalConditionReminder() {
        do {
            guard let reminder = try physicalConditionReminderDataSource.fetchPhysicalConditionReminder() else {
                return
            }
            physicalConditionReminder = reminder
        } catch {
            setError(withMessage: "体調リマインダー情報の取得に失敗しました")
        }
    }

    func fetchHydrationReminder() {
        do {
            guard let reminder = try hydrationReminderDataSource.fetchHydrationReminder() else {
                return
            }
            hydrationReminder = reminder
        } catch {
            setError(withMessage: "水分摂取リマインダー情報の取得に失敗しました")
        }
    }

    func checkNotificationStatus() async {
        let center = UNUserNotificationCenter.current()

        if await checkAuthorizeNotificationSetting(center: center) {
            isNotificationEnabled = true
            return
        }
        isNotificationEnabled = false
    }

    func scheduleNotification() async {
        let center = UNUserNotificationCenter.current()
        do {
            if try await center.requestAuthorization(options: [.alert, .sound]) {
                isNotificationEnabled = true
            }
        } catch {
            setError(withMessage: "通知の許可リクエストまたは通知スケジュールに失敗しました")
        }
    }

    func createReminderWithEmptyNotificationSetting() async {
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.createPhysicalConditionReminder()
            }
            group.addTask {
                await self.createHydrationReminder()
            }
        }
    }

    private func createPhysicalConditionReminder() async {
        do {
            let physicalConditionReminder = PhysicalConditionReminder(isActive: false, sendsToiOS: false, sendsTowatchOS: false)
            try physicalConditionReminderDataSource.insertPhysicalConditionReminder(physicalConditionReminder: physicalConditionReminder)
            fetchPhysicalConditionReminder()

        } catch {
            setError(withMessage: "体調リマインダーの登録に失敗しました")
        }
    }

    private func createHydrationReminder() async {
        do {
            let hydrationReminder = HydrationReminder(isActive: false, sendsToiOS: false, sendsTowatchOS: false)
            try hydrationReminderDataSource.insertHydrationReminder(hydrationReminder: hydrationReminder)
            fetchHydrationReminder()
        } catch {
            setError(withMessage: "水分摂取リマインダーの登録に失敗しました")
        }
    }

    private func checkAuthorizeNotificationSetting(center: UNUserNotificationCenter) async -> Bool {
        let checkStatus = await center.notificationSettings()
        if checkStatus.authorizationStatus == .authorized {
            return true
        }
        return false
    }
}
