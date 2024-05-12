//
//  PhysicalConditionReminderEditView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/07.
//

import SwiftUI

struct PhysicalConditionReminderEditView: View {
    var reminder: PhysicalConditionReminder
    @StateObject var viewModel: PhysicalConditionReminderEditViewModel
    @EnvironmentObject var router: SettingScreenNavigationRouter

    init(reminder: PhysicalConditionReminder) {
        self.reminder = reminder
        _viewModel = StateObject(wrappedValue: PhysicalConditionReminderEditViewModel(reminder: reminder))
    }

    var body: some View {
        ReminderBaseView(
            viewModel: viewModel,
            buttonTitle: "保存する",
            textTitle: "体調リマインドについて設定して下さい",
            buttonAction: {
                Task {
                    if await viewModel.updatePhysicalConditionReminder() {
                        router.items.removeLast()
                    }
                }
            }
        )
    }
}
