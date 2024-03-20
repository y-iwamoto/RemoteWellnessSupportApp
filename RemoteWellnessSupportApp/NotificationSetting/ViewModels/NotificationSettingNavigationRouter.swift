//
//  NotificationSettingNavigationRouter.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import Foundation

final class NotificationSettingNavigationRouter: ObservableObject {
    @MainActor @Published var items: [NotificationSettingNavigationItem] = []
}
