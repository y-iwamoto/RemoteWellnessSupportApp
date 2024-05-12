//
//  HydrationReminderEditViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/12.
//

import Foundation

class HydrationReminderEditViewModel: BaseHydrationReminder, ReminderViewModelProtocol {
    @Published var hydrationReminder: HydrationReminder

    init(reminder: HydrationReminder) {
        hydrationReminder = reminder
        super.init()
        assignReminderForEditInitial(reminder: reminder)
    }

    func updateHydrationReminder() async -> Bool {
        guard validateInputs() else {
            return false
        }
        assignHydrationReminderForUpdate()
        do {
            try dataSource.updateHydrationReminder()
        } catch {
            setError(withMessage: "水分摂取通知設定の更新に失敗しました")
            return false
        }
        return await sendNotification(for: hydrationReminder, type: .hydration)
    }

    private func assignHydrationReminderForUpdate() {
        hydrationReminder.isActive = isReminderActive
        switch selectedTab {
        case .repeating:
            assignHydrationReminderTypeAndInterval()
        case .scheduled:
            assignHydrationReminderScheduledTimes()
        }
    }

    private func assignHydrationReminderTypeAndInterval() {
        let interval = selectedHour * 3600 + selectedMinute * 60
        hydrationReminder.type = .repeating
        hydrationReminder.interval = interval
    }

    private func assignHydrationReminderScheduledTimes() {
        let scheduledTimes = scheduledTimeSelections.map(\.selectedTime).sorted()
        hydrationReminder.type = .scheduled
        hydrationReminder.scheduledTimes = scheduledTimes
    }
}
