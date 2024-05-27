//
//  BasePomodoroReminder.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/15.
//

import Foundation

class BasePomodoroReminder: BaseViewModel {
    let dataSource: PomodoroReminderDataSource
    @Published var isReminderActive = true

    init(dataSource: PomodoroReminderDataSource = PomodoroReminderDataSource.shared) {
        self.dataSource = dataSource
    }
}
