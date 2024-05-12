//
//  SettingScreenNavigationRouter.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import Foundation

enum SettingScreenNavigationItem: Hashable {
    case profileSetting
    case reminderEditList
    case nicknameEditInput(profile: Profile)
    case workDaySelectEdit(profile: Profile)
    case workTimeEditInput(profile: Profile)
    case restTimeEditInput(profile: Profile)
    case goalSettingEditInput(profile: Profile)
    case physicalConditionReminderEdit(reminder: PhysicalConditionReminder)
    case hydrationReminderEdit(reminder: HydrationReminder)
}

final class SettingScreenNavigationRouter: ObservableObject {
    @MainActor @Published var items: [SettingScreenNavigationItem] = []
}
