//
//  PomodoroReminder.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/14.
//

import Foundation
import SwiftData

@Model
class PomodoroReminder {
    @Attribute(.unique) var id: String = UUID().uuidString
    var isActive: Bool
    var createdAt: Date
    var updatedAt: Date

    init(id: String = UUID().uuidString, isActive: Bool, createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.isActive = isActive
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
