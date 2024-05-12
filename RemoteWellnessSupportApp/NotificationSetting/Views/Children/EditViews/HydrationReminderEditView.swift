//
//  HydrationReminderEditView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/12.
//

import SwiftUI

struct HydrationReminderEditView: View {
    var reminder: HydrationReminder
    @StateObject var viewModel: HydrationReminderEditViewModel
    @EnvironmentObject var router: SettingScreenNavigationRouter

    init(reminder: HydrationReminder) {
        self.reminder = reminder
        _viewModel = StateObject(wrappedValue: HydrationReminderEditViewModel(reminder: reminder))
    }

    var body: some View {
        ReminderBaseView(
            viewModel: viewModel,
            buttonTitle: "保存する",
            textTitle: "水分摂取リマインドについて設定して下さい",
            buttonAction: {
                Task {
                    if await viewModel.updateHydrationReminder() {
                        router.items.removeLast()
                    }
                }
            }
        )
    }
}
