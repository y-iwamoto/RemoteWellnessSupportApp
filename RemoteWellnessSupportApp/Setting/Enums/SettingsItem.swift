//
//  SettingsItem.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import Foundation

enum SettingsItem {
    enum Label: String {
        case profileEditList = "プロフィール"
        case reminderEditList = "リマインダー変更"
        case accountDeletion = "退会"
    }

    enum ImageName: String {
        case profileEditList = "person.circle"
        case reminderEditList = "clock"
        case accountDeletion = "person.2.slash"
    }
}
