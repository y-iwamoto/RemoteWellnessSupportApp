//
//  HydrationReminder.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/10.
//

import Foundation
import SwiftData

@Model
class HydrationReminder: BaseReminderProtocol {
    @Attribute(.unique) var id: String = UUID().uuidString
    var isActive: Bool
    var sendsToiOS: Bool
    var sendsTowatchOS: Bool
    var type: Reminder?
    var interval: Int?
    var scheduledTimes: [Date]?
    var createdAt: Date
    var updatedAt: Date

    init(id: String = UUID().uuidString, isActive: Bool, sendsToiOS: Bool,
         sendsTowatchOS: Bool, type: Reminder? = nil, interval: Int? = nil,
         scheduledTimes: [Date]? = nil, createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.isActive = isActive
        self.sendsToiOS = sendsToiOS
        self.sendsTowatchOS = sendsTowatchOS
        self.type = type
        self.interval = interval
        self.scheduledTimes = scheduledTimes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
