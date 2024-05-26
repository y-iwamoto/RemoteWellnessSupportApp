//
//  PomodoroTimerViewModel+BreakTimer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/16.
//

import Foundation

extension PomodoroTimerViewModel {
    func startBraekMode() {
        timer.invalidate()
        secondsLeft = PomodoroTimerViewModel.BreakTime
        currentMaxTime = PomodoroTimerViewModel.BreakTime
        timerMode = .breakMode
        Task {
            await sendBreakTimerEndNotification()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if secondsLeft == 0 {
                endBreakTimer()
            } else {
                secondsLeft -= 1
            }
        }
    }

    func endBreakTimer() {
        guard let pomodoroGroupId else {
            fatalError("不正な値です")
        }
        let pomodoro = Pomodoro(pomodoroGroupId: pomodoroGroupId.uuidString, activityType: .breakTime)

        do {
            try dataSource.insertPomodoro(pomodoro: pomodoro)
            NotificationCenter.default.post(name: .didUpdatePomodoroData, object: nil)
        } catch {
            setError(withMessage: "登録処理に失敗しました", error: error)
        }
        resetTimer()
    }
}
