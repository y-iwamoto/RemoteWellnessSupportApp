//
//  GoalSettingEditInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/04.
//

import SwiftUI

struct GoalSettingEditInputView: View {
    var profile: Profile
    @StateObject var viewModel: GoalSettingEditInputViewModel
    @EnvironmentObject var router: SettingScreenNavigationRouter

    init(profile: Profile) {
        self.profile = profile
        _viewModel = StateObject(
            wrappedValue:
            GoalSettingEditInputViewModel(profile: profile))
    }

    var body: some View {
        CommonLayoutView(
            title: "1日の目標値を設定して下さい",
            buttonTitle: "保存する",
            content: {
                VStack {
                    HStack {
                        Text("水分摂取")
                        TextInput(labelName: "ml", value: $viewModel.hydrationGoal)
                            .onChange(of: viewModel.hydrationGoal) { _, newState in
                                viewModel.hydrationGoal = viewModel.extractNumbersFromString(newState)
                            }
                            .keyboardType(.numberPad)
                    }
                }
            },
            buttonAction: {
                if viewModel.updateGoalSettings() {
                    router.items.removeLast()
                }
            }
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
