//
//  PhysicalConditionReminderView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/17.
//

import SwiftUI

struct PhysicalConditionReminderView: View {
    @StateObject private var viewModel = PhysicalConditionReminderViewModel()
    @EnvironmentObject private var router: NotificationSettingNavigationRouter

    var body: some View {
        PhysicalConditionReminderBaseView(
            viewModel: viewModel,
            buttonTitle: "次へ進む",
            buttonAction: {
                Task {
                    if await viewModel.savePhysicalConditionReminderSetteing() {
                        router.items.append(.notificationSettingEnd)
                    }
                }
            }
        )
    }
}
