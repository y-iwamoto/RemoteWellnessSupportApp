//
//  PomodoroTimerViewModel+StopTimer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/16.
//

import Foundation

extension PomodoroTimerViewModel {
    func pauseTimer() {
        cancelNotification()
        timer?.cancel()
        timerMode = .paused
    }

    func resetTimer() {
        cancelNotification()
        timer?.cancel()
        secondsLeft = PomodoroTimerViewModel.MaxTimer
        currentMaxTime = PomodoroTimerViewModel.MaxTimer
        timerMode = .initial
        pomodoroGroupId = nil
    }

    func resumeTimer() {
        if timerMode == .paused {
            if currentMaxTime == PomodoroTimerViewModel.BreakTime {
                timerMode = .breakMode
            } else {
                timerMode = .running
            }
            Task {
                await resumeNotification()
            }
            startDispatchMainTimer()
        }
    }

    private func cancelNotification() {
        let type = timerMode == .breakMode ? PomodoroReminderType.breakTimer : PomodoroReminderType.mainTimer
        cancelCurrentNotification(type: type)
    }
}
