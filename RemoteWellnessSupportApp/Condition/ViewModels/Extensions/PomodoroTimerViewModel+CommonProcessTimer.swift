//
//  PomodoroTimerViewModel+CommonProcessTimer.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/25.
//

import Foundation

extension PomodoroTimerViewModel {
    func backgroundSetTimer() {
        backgroundEntryTimestamp = Date()
        remain = secondsLeft
    }

    func syncTimerOnActive() {
        guard let backgroundEntry = backgroundEntryTimestamp else {
            return
        }

        let backgroundDuration = Date().timeIntervalSince(backgroundEntry)
        let remainingTime = Double(remain) - backgroundDuration

        if remainingTime <= 0 {
            if timerMode == .running {
                endMainTimer()
            } else if timerMode == .breakMode {
                endBreakTimer()
            }
        } else {
            secondsLeft = Int(remainingTime.rounded(.toNearestOrAwayFromZero))
        }
    }

    func formatPomodoroTime(_ second: Int) -> String {
        let formattedString = formatter.string(from: TimeInterval(second))!
        return formattedString
    }
}
