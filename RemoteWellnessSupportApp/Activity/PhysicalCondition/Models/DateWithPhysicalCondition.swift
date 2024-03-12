//
//  DateWithPhysicalCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/10.
//

import Foundation

struct DateWithPhysicalCondition: Hashable {
    var date: Date
    var id: UUID

    init(date: Date) {
        self.date = date
        id = UUID()
    }
}
