//
//  BaseHydrationReminder.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/11.
//

import Foundation

class BaseHydrationReminder: BaseReminderScheduler {
    let dataSource: HydrationReminderDataSource

    init(dataSource: HydrationReminderDataSource = HydrationReminderDataSource.shared) {
        self.dataSource = dataSource
    }
}
