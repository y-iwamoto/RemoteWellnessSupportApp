//
//  PomodoroReminderType.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/27.
//

import Foundation

enum PomodoroReminderType: String {
    case mainTimer
    case breakTimer

    static func fromIdentifier(_ identifier: String) -> PomodoroReminderType? {
        PomodoroReminderType(rawValue: identifier)
    }
}
