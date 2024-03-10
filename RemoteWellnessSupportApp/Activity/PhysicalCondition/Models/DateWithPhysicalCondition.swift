//
//  DateWithPhysicalCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/10.
//

import Foundation

struct DateWithPhysicalCondition: Hashable {
    var date: String
    var id: UUID

    init(date: String) {
        self.date = date
        id = UUID()
    }
}
