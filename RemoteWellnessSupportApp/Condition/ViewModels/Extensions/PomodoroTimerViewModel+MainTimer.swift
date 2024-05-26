//
//  PomodoroTimerViewModel+MainTimer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/16.
//

import Foundation

extension PomodoroTimerViewModel {
    func startTimer() {
        timer?.cancel()
        secondsLeft = PomodoroTimerViewModel.MaxTimer
        currentMaxTime = PomodoroTimerViewModel.MaxTimer
        timerMode = .running
        pomodoroGroupId = UUID()
        timerStartTimestamp = Date()
        Task {
            await sendMainTimerEndNotification()
        }
        startDispatchMainTimer()
    }

    func endMainTimer() {
        timer?.cancel()
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

    func startDispatchMainTimer() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        timer?.schedule(deadline: .now(), repeating: 1.0)
        timer?.setEventHandler { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                if self.secondsLeft == 0 {
                    if self.timerMode == .running {
                        self.endMainTimer()
                    } else {
                        self.resetTimer()
                    }
                } else {
                    self.secondsLeft -= 1
                }
            }
        }
        timer?.resume()
    }
}
