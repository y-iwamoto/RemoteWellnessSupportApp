//
//  Reminder+Extensions.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/20.
//

import Foundation

extension Reminder: TabTitleConvertible {
    var tabTitle: String {
        rawValue
    }
}
