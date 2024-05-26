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
        timer.invalidate()
        timerMode = .paused
    }

    func resetTimer() {
        cancelNotification()
        timer.invalidate()
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
    }

    private func cancelNotification() {
        let type = timerMode == .breakMode ? PomodoroReminderType.breakTimer : PomodoroReminderType.mainTimer
        cancelCurrentNotification(type: type)
    }
}
