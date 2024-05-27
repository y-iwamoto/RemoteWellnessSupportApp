//
//  PomodoroTimerViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import Foundation
import SwiftUI

class PomodoroTimerViewModel: BaseViewModel {
    static let shared = PomodoroTimerViewModel()

    let dataSource: PomodoroDataSource
    let pomodoroReminderDataSource: PomodoroReminderDataSource
    static let MaxTimer: Int = 1500
    static let BreakTime: Int = 300
    @Published var timerMode: PomodoroTimerMode = .initial
    @Published var secondsLeft: Int = MaxTimer
    @Published var currentMaxTime: Int = MaxTimer
    @Published var completedPomodoroCount = 0
    var timerStartTimestamp: Date?
    var backgroundEntryTimestamp: Date?
    var remain: Int = 0
    var pomodoroReminder: PomodoroReminder?
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
    var timer: DispatchSourceTimer?

    init(dataSource: PomodoroDataSource = PomodoroDataSource.shared,
         pomodoroReminderDataSource: PomodoroReminderDataSource = PomodoroReminderDataSource.shared) {
        self.dataSource = dataSource
        self.pomodoroReminderDataSource = pomodoroReminderDataSource
        super.init()
        do {
            try initializeDataSources()
        } catch {
            setError(withMessage: "初期取得処理に失敗しました", error: error)
        }
    }

    deinit {
        timer?.cancel()
    }

    func initializeDataSources() throws {
        let workTimeEndPomodoros = try fetchCount()
        completedPomodoroCount = workTimeEndPomodoros.count
        pomodoroReminder = try fetchReminder()
        isReminderActive = pomodoroReminder?.isActive ?? false
    }
}
