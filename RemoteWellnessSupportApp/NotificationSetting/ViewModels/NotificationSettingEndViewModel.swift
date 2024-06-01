//
//  NotificationSettingEndViewModel.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import Foundation
import SwiftUI

class NotificationSettingEndViewModel: ObservableObject {
    @AppStorage(Const.AppStatus.hasCompletedNotificationSetting) var hasCompletedNotificationSetting
        = Const.AppDefaults.hasCompletedNotificationSetting

    func endNotificationSettings() {
        hasCompletedNotificationSetting = true
    }
}
