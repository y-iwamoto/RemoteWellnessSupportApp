//
//  PhysicalCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/18.
//

import Foundation
import SwiftData

@Model
class PhysicalCondition {
    @Attribute(.unique) var id: String = UUID().uuidString
    var memo: String
    var rating: Int
    var entryDate: Date
    var createdAt: Date
    var updatedAt: Date

    init(id: String = UUID().uuidString,
         memo: String, rating: Int, entryDate: Date, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.memo = memo
        self.rating = rating
        self.entryDate = entryDate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
