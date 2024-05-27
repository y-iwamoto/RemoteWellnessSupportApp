//
//  PomodoroTimerViewModel+BreakTimer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/16.
//

import Foundation

extension PomodoroTimerViewModel {
    func startBreakMode() {
        timer?.cancel()
        secondsLeft = PomodoroTimerViewModel.BreakTime
        currentMaxTime = PomodoroTimerViewModel.BreakTime
        timerMode = .breakMode
        Task {
            await sendBreakTimerEndNotification()
        }
        startBreakDispatchTimer()
    }

    func endBreakTimer() {
        guard let pomodoroGroupId else {
            setError(withMessage: "不正な値です")
            return
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

    private func startBreakDispatchTimer() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        timer?.schedule(deadline: .now(), repeating: 1.0)
        timer?.setEventHandler { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                if self.secondsLeft == 0 {
                    self.endBreakTimer()
                } else {
                    self.secondsLeft -= 1
                }
            }
        }
        timer?.resume()
    }
}
