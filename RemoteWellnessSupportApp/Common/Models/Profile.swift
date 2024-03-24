//
//  Profile.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/21.
//

import Foundation
import SwiftData

@Model
class Profile {
    @Attribute(.unique) var id: String = UUID().uuidString
    var nickname: String
    var workDays: [WorkDay]
    var workTimeFrom: Date
    var workTimeTo: Date
    var hydrationGoal: Double
    var restTimePeriods: [RestTimePeriod]
    var createdAt: Date
    var updatedAt: Date

    init(id: String = UUID().uuidString, nickname: String, workDays: [WorkDay], workTimeFrom: Date, workTimeTo: Date,
         hydrationGoal: Double, restTimePeriods: [RestTimePeriod], createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.nickname = nickname
        self.workDays = workDays
        self.workTimeFrom = workTimeFrom
        self.workTimeTo = workTimeTo
        self.hydrationGoal = hydrationGoal
        self.restTimePeriods = restTimePeriods
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
