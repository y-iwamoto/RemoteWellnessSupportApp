//
//  PomodoroTimerViewModel+FetchReminder.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/17.
//

import Foundation

extension PomodoroTimerViewModel {
    func fetchReminder() -> PomodoroReminder? {
        do {
            let reminder = try pomodoroReminderDataSource.fetchPomodoroReminder()
            return reminder
        } catch {
            setError(withMessage: "取得処理に失敗しました", error: error)
        }
        return nil
    }
}
