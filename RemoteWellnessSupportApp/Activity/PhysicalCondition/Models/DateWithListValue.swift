//
//  DateWithListValue.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/10.
//

import Foundation

struct DateWithListValue: Hashable {
    var date: Date
    let id: UUID

    init(date: Date) {
        self.date = date
        id = UUID()
    }
}
