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
        assignPhysicalConditionReminderForInitial()
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

        return await sendNotification(for: physicalConditionReminder)
    }

    private func assignPhysicalConditionReminderForInitial() {
        isReminderActive = physicalConditionReminder.isActive
        selectedTab = physicalConditionReminder.type ?? Reminder.repeating
        if let interval = physicalConditionReminder.interval {
            (selectedHour, selectedMinute) = calculateTime(from: interval)
        }
        scheduledTimeSelections = convertToTimeSelections(from: physicalConditionReminder.scheduledTimes)
    }

    private func calculateTime(from interval: Int) -> (hour: Int, minute: Int) {
        let selectedHour = interval / 3600
        let selectedMinute = (interval % 3600) / 60
        return (selectedHour, selectedMinute)
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

    private func convertToTimeSelections(from scheduledTimes: [Date]?) -> [TimeSelection] {
        guard let scheduledTimes else {
            return [TimeSelection()]
        }

        return scheduledTimes.sorted().map { TimeSelection(selectedTime: $0) }
    }
}
