//
//  PomodoroTimerViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import Foundation
import SwiftUI

class PomodoroTimerViewModel: BaseViewModel {
    let dataSource: PomodoroDataSource
    let pomodoroReminderDataSource: PomodoroReminderDataSource
    static let MaxTimer: Int = 15
    static let BreakTime: Int = 3
    @Published var timerMode: PomodoroTimerMode = .initial
    @Published var secondsLeft: Int = MaxTimer
    @Published var currentMaxTime: Int = MaxTimer
    @Published var completedPomodoroCount = 0
    var timerStartTimestamp: Date?
    var backgroundEntryTimestamp: Date?
    var remain: Int = 0
    var pomodoroRemindeer: PomodoroReminder?
    var isReminderActive = false

    var progress: CGFloat {
        CGFloat(secondsLeft) / CGFloat(currentMaxTime)
    }

    var foregroundColor: Color {
        switch timerMode {
        case .running:
            Color.green
        case .breakMode:
            Color.blue
        default:
            Color.red
        }
    }

    let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .full
        formatter.calendar?.locale = Locale(identifier: "ja_JP")
        return formatter
    }()

    var pomodoroGroupId: UUID?
    var timer = Timer()

    init(dataSource: PomodoroDataSource = PomodoroDataSource.shared,
         pomodoroReminderDataSource: PomodoroReminderDataSource = PomodoroReminderDataSource.shared) {
        self.dataSource = dataSource
        self.pomodoroReminderDataSource = pomodoroReminderDataSource
        super.init()
        let workTimeEndPomodoros = fetchCount()
        completedPomodoroCount = workTimeEndPomodoros.count
        pomodoroRemindeer = fetchReminder()
        isReminderActive = pomodoroRemindeer?.isActive ?? false
    }
}
