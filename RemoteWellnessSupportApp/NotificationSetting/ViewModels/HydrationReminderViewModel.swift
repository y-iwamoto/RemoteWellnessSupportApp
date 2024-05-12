//
//  HydrationReminderViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/11.
//

import Foundation

class HydrationReminderViewModel: BaseHydrationReminder, ReminderViewModelProtocol {
    func saveHydrationReminder() async -> Bool {
        guard validateInputs() else {
            return false
        }
        let hydrationReminder = assignHydrationReminder()

        guard await insertHydrationReminderIntoDataSource(hydrationReminder) else {
            return false
        }

        return await sendNotification(for: hydrationReminder, type: .hydration)
    }

    private func assignHydrationReminder() -> HydrationReminder {
        let sendsToiOS = isReminderActive
        let sendsTowatchOS = false
        let interval = selectedHour * 3600 + selectedMinute * 60
        let scheduledTimes = scheduledTimeSelections.map(\.selectedTime).sorted()

        let hydrationReminder = HydrationReminder(isActive: isReminderActive, sendsToiOS: sendsToiOS, sendsTowatchOS: sendsTowatchOS)

        if isReminderActive {
            switch selectedTab {
            case .repeating:
                hydrationReminder.type = .repeating
                hydrationReminder.interval = interval
            case .scheduled:
                hydrationReminder.type = .scheduled
                hydrationReminder.scheduledTimes = scheduledTimes
            }
        }

        return hydrationReminder
    }

    @MainActor private func insertHydrationReminderIntoDataSource(_ reminder: HydrationReminder) -> Bool {
        do {
            try dataSource.insertHydrationReminder(hydrationReminder: reminder)
            return true
        } catch {
            setError(withMessage: "通知設定の登録に失敗しました")
            return false
        }
    }
}
