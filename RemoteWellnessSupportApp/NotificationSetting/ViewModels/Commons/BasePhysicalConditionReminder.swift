//
//  BasePhysicalConditionReminder.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/07.
//

import Foundation
import UserNotifications

class BasePhysicalConditionReminder: BaseReminderScheduler {
    let dataSource: PhysicalConditionReminderDataSource

    init(dataSource: PhysicalConditionReminderDataSource = PhysicalConditionReminderDataSource.shared) {
        self.dataSource = dataSource
    }
}
