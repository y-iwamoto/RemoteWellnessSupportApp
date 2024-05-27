//
//  PomodoroTimerViewModel+FetchReminder.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/17.
//

import Foundation

extension PomodoroTimerViewModel {
    func fetchReminder() throws -> PomodoroReminder? {
        let reminder = try pomodoroReminderDataSource.fetchPomodoroReminder()
        return reminder
    }
}
