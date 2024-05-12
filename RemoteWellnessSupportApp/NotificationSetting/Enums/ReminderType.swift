//
//  ReminderType.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/11.
//

import Foundation

enum ReminderType: String {
    case hydration
    case physicalCondition

    static func fromIdentifier(_ identifier: String) -> ReminderType? {
        ReminderType(rawValue: identifier)
    }
}
