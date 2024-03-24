//
//  ProfileNavigationRouter.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/22.
//

import Foundation

enum ProfileNavigationItem: Hashable {
    case nicknameInput
    case workDaySelect
    case workTimeInput
    case restTimeInput
    case goalSettingInput
}

final class ProfileNavigationRouter: ObservableObject {
    @MainActor @Published var items: [ProfileNavigationItem] = []
}
