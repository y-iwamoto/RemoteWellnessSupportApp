//
//  GoalSettingInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import SwiftUI

struct GoalSettingInputView: View {
    @Binding var hydrationGoal: String
    @StateObject var viewModel = GoalSettingInputViewModel()
    @EnvironmentObject var router: ProfileNavigationRouter

    var saveProfile: () -> Bool

    var body: some View {
        CommonLayoutView(
            title: "1日の目標摂取値を設定して下さい",
            buttonTitle: "次へ進む",
            content: {
                VStack {
                    HStack {
                        Text("水分摂取")
                        TextInput(labelName: "2000ml", value: $hydrationGoal)
                            .onChange(of: hydrationGoal) { _, newState in
                                hydrationGoal = viewModel.extractNumbersFromString(newState)
                            }
                            .keyboardType(.numberPad)
                    }
                }
            },
            buttonAction: {
                if viewModel.inputValidate(goalValue: hydrationGoal), saveProfile() {
                    router.items.append(.profileEnd)
                }
            }
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
