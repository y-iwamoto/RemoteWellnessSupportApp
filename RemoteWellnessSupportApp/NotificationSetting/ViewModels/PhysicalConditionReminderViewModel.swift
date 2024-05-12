//
//  PhysicalConditionReminderViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import Foundation
import UserNotifications

class PhysicalConditionReminderViewModel: BasePhysicalConditionReminder, ReminderViewModelProtocol {
    func savePhysicalConditionReminderSetting() async -> Bool {
        guard validateInputs() else {
            return false
        }

        let physicalConditionReminder = assignPhysicalConditionReminder()

        guard await insertPhysicalConditionReminderIntoDataSource(physicalConditionReminder) else {
            return false
        }

        return await sendNotification(for: physicalConditionReminder, type: .physicalCondition)
    }

    private func assignPhysicalConditionReminder() -> PhysicalConditionReminder {
        let sendsToiOS = isReminderActive
        let sendsTowatchOS = false
        let interval = selectedHour * 3600 + selectedMinute * 60
        let scheduledTimes = scheduledTimeSelections.map(\.selectedTime).sorted()

        let physicalConditionReminder = PhysicalConditionReminder(isActive: isReminderActive, sendsToiOS: sendsToiOS, sendsTowatchOS: sendsTowatchOS)

        if isReminderActive {
            switch selectedTab {
            case .repeating:
                physicalConditionReminder.type = .repeating
                physicalConditionReminder.interval = interval
            case .scheduled:
                physicalConditionReminder.type = .scheduled
                physicalConditionReminder.scheduledTimes = scheduledTimes
            }
        }

        return physicalConditionReminder
    }

    @MainActor private func insertPhysicalConditionReminderIntoDataSource(_ reminder: PhysicalConditionReminder) -> Bool {
        do {
            try dataSource.insertPhysicalConditionReminder(physicalConditionReminder: reminder)
            return true
        } catch {
            setError(withMessage: "通知設定の登録に失敗しました")
            return false
        }
    }
}
