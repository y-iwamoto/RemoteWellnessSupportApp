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
    var workDays: [WorkDay]
    var workTimeFrom: Date
    var workTimeTo: Date
    var hydrationGoal: Double
    var stepGoal: Double
    var restTimePeriods: [RestTimePeriod]
    var createdAt: Date
    var updatedAt: Date

    init(id: String = UUID().uuidString, workDays: [WorkDay], workTimeFrom: Date, workTimeTo: Date,
         hydrationGoal: Double, stepGoal: Double, restTimePeriods: [RestTimePeriod],
         createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.workDays = workDays
        self.workTimeFrom = workTimeFrom
        self.workTimeTo = workTimeTo
        self.hydrationGoal = hydrationGoal
        self.stepGoal = stepGoal
        self.restTimePeriods = restTimePeriods
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
