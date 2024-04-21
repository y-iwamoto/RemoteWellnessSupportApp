//
//  Pomodoro.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/18.
//

import Foundation
import SwiftData

@Model
class Pomodoro {
    @Attribute(.unique) var id: String = UUID().uuidString
    var pomodoroGroupId: String
    var createdAt: Date
    var updatedAt: Date
    var registeredAt: Date
    var activityType: PomodoroActivityType

    init(id: String = UUID().uuidString, pomodoroGroupId: String,
         createdAt: Date = Date(), updatedAt: Date = Date(), registeredAt: Date = Date(), activityType: PomodoroActivityType) {
        self.id = id
        self.pomodoroGroupId = pomodoroGroupId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.registeredAt = registeredAt
        self.activityType = activityType
    }
}
