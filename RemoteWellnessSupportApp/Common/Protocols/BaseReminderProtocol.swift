//
//  BaseReminderProtocol.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/11.
//

import Foundation

protocol BaseReminderProtocol {
    var id: String { get }
    var isActive: Bool { get }
    var sendsToiOS: Bool { get }
    var sendsTowatchOS: Bool { get }
    var type: Reminder? { get }
    var interval: Int? { get }
    var scheduledTimes: [Date]? { get }
    var createdAt: Date { get }
    var updatedAt: Date { get }
}
