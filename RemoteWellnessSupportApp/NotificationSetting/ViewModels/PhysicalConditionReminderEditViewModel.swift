//
//  PhysicalConditionReminderEditViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/07.
//

import Foundation

class PhysicalConditionReminderEditViewModel: BasePhysicalConditionReminder, ReminderViewModelProtocol {
    @Published var physicalConditionReminder: PhysicalConditionReminder

    init(reminder: PhysicalConditionReminder) {
        physicalConditionReminder = reminder
        super.init()
        assignReminderForEditInitial(reminder: physicalConditionReminder)
    }

    func updatePhysicalConditionReminder() async -> Bool {
        guard validateInputs() else {
            return false
        }
        assignPhysicalConditionReminderForUpdate()
        do {
            try dataSource.updatePhysicalConditionReminder()
        } catch {
            setError(withMessage: "体調通知設定の更新に失敗しました")
            return false
        }
        if physicalConditionReminder.isActive {
            return await sendNotification(for: physicalConditionReminder, type: .physicalCondition)
        } else {
            await removeNotification(for: physicalConditionReminder, type: .physicalCondition)
            return true
        }
    }

    private func assignPhysicalConditionReminderForUpdate() {
        physicalConditionReminder.isActive = isReminderActive
        switch selectedTab {
        case .repeating:
            let interval = selectedHour * 3600 + selectedMinute * 60
            physicalConditionReminder.type = .repeating
            physicalConditionReminder.interval = interval
        case .scheduled:
            let scheduledTimes = scheduledTimeSelections.map(\.selectedTime).sorted()
            physicalConditionReminder.type = .scheduled
            physicalConditionReminder.scheduledTimes = scheduledTimes
        }
    }
}
