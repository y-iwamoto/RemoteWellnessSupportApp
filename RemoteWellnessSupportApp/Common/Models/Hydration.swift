//
//  Hydration.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Foundation
import SwiftData

@Model
class Hydration {
    @Attribute(.unique) var id: String = UUID().uuidString
    var rating: Int
    var entryDate: Date
    var createdAt: Date
    var updatedAt: Date

    init(id: String = UUID().uuidString, rating: Int, entryDate: Date,
         createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.rating = rating
        self.entryDate = entryDate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
