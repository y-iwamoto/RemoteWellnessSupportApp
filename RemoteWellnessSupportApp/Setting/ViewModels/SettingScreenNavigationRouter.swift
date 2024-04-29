//
//  SettingScreenNavigationRouter.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import Foundation

enum SettingScreenNavigationItem: Hashable {
    case profileEditList
    case reminderEditList
}

final class SettingScreenNavigationRouter: ObservableObject {
    @MainActor @Published var items: [SettingScreenNavigationItem] = []
}
