//
//  HydrationReminderView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/11.
//

import SwiftUI

struct HydrationReminderView: View {
    @StateObject private var viewModel = HydrationReminderViewModel()
    @EnvironmentObject private var router: NotificationSettingNavigationRouter

    var body: some View {
        ReminderBaseView(
            viewModel: viewModel,
            buttonTitle: "次へ進む",
            textTitle: "水分摂取リマインドについて設定して下さい",
            buttonAction: {
                Task {
                    if await viewModel.saveHydrationReminder() {
                        router.items.append(.pomodoroReminder)
                    }
                }
            }
        )
    }
}

#Preview {
    HydrationReminderView()
}
