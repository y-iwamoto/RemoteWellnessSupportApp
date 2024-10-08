//
//  SettingList.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import SwiftUI

struct SettingList: View {
    @StateObject var viewModel = SettingListViewModel()
    @EnvironmentObject var router: SettingScreenNavigationRouter
    @AppStorage(Const.AppStatus.hasCompletedOnboarding) var hasCompletedOnboarding: Bool
        = Const.AppDefaults.hasCompletedOnboarding
    @AppStorage(Const.AppStatus.hasCompletedNotificationSetting) var hasCompletedNotificationSetting
        = Const.AppDefaults.hasCompletedNotificationSetting
    @AppStorage(Const.AppStatus.hasCompletedProfileRegister) var hasCompletedProfileRegister
        = Const.AppDefaults.hasCompletedProfileRegister

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SettingItemView(imageName: SettingsItem.ImageName.profileEditList.rawValue,
                                    title: SettingsItem.Label.profileEditList.rawValue,
                                    geometry: geometry) {
                        router.items.append(SettingScreenNavigationItem.profileSetting)
                    }

                    SettingItemView(imageName: SettingsItem.ImageName.reminderEditList.rawValue,
                                    title: SettingsItem.Label.reminderEditList.rawValue,
                                    geometry: geometry) {
                        router.items.append(SettingScreenNavigationItem.reminderEditList)
                    }

                    SettingItemView(imageName: SettingsItem.ImageName.accountDeletion.rawValue,
                                    title: SettingsItem.Label.accountDeletion.rawValue,
                                    geometry: geometry) {
                        viewModel.showModal = true
                    }
                    .alert("退会しますか？", isPresented: $viewModel.showModal) {
                        Button("キャンセル", role: .cancel) {}
                        Button("退会する", role: .destructive) {
                            viewModel.unsubscribe()
                            hasCompletedNotificationSetting = false
                            hasCompletedProfileRegister = false
                            hasCompletedOnboarding = false
                        }
                    } message: {
                        Text("退会すると今までのデータは削除されます")
                    }
                }
            }
        }
    }
}
