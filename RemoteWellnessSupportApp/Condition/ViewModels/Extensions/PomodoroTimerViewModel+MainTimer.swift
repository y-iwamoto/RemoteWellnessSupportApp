//
//  PomodoroTimerViewModel+MainTimer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/16.
//

import Foundation

extension PomodoroTimerViewModel {
    func startTimer() {
        timer.invalidate()
        secondsLeft = PomodoroTimerViewModel.MaxTimer
        currentMaxTime = PomodoroTimerViewModel.MaxTimer
        timerMode = .running
        pomodoroGroupId = UUID()
        timerStartTimestamp = Date()
        Task {
            await sendMainTimerEndNotification()
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if secondsLeft == 0 {
                if timerMode == .running {
                    endMainTimer()
                } else {
                    resetTimer()
                }
            } else {
                secondsLeft -= 1
            }
        }
    }

    func endMainTimer() {
        timer.invalidate()
        secondsLeft = PomodoroTimerViewModel.BreakTime
        currentMaxTime = PomodoroTimerViewModel.BreakTime
        timerMode = .initial
        guard let pomodoroGroupId else {
            setError(withMessage: "不正な値です")
            return
        }
        let pomodoro = Pomodoro(pomodoroGroupId: pomodoroGroupId.uuidString, activityType: .workTime)
        do {
            try dataSource.insertPomodoro(pomodoro: pomodoro)

            let workTimeEndPomodoros = fetchCount()
            completedPomodoroCount = workTimeEndPomodoros.count
        } catch {
            setError(withMessage: "登録処理に失敗しました", error: error)
        }
    }
}
