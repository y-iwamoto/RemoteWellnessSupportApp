//
//  PomodoroReminderViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/15.
//

import Foundation

class PomodoroReminderViewModel: BasePomodoroReminder {
    func savePomodoroReminder() -> Bool {
        let reminder = PomodoroReminder(isActive: isReminderActive)
        guard insertPomodoroReminder(reminder) else {
            setError(withMessage: "通知設定の登録に失敗しました")
            return false
        }
        return true
    }

    private func insertPomodoroReminder(_ reminder: PomodoroReminder) -> Bool {
        do {
            try dataSource.insertPomodoroReminder(pomodoroReminder: reminder)
            return true
        } catch {
            return false
        }
    }
}
