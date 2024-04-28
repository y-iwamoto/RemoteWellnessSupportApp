//
//  GoalSettingInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import SwiftUI

struct GoalSettingInputView: View {
    @Binding var hydrationGoal: String
    @Binding var stepGoal: String
    @StateObject var viewModel = GoalSettingInputViewModel()
    @AppStorage(Const.AppStatus.hasCompletedProfileRegister) var hasCompletedProfileRegister = false

    var saveProfile: () -> Bool

    var body: some View {
        CommonLayoutView(
            title: "1時間あたりの目標値を設定して下さい",
            buttonTitle: "次へ進む",
            content: {
                VStack {
                    HStack {
                        Text("水分摂取")
                        TextInput(labelName: "ml", value: $hydrationGoal)
                            .onChange(of: hydrationGoal) { _, newState in
                                hydrationGoal = viewModel.extractNumbersFromString(newState)
                            }
                            .keyboardType(.numberPad)
                    }

                    HStack {
                        Text("歩数")
                        TextInput(labelName: "歩", value: $stepGoal)
                            .onChange(of: stepGoal) { _, newState in
                                stepGoal = viewModel.extractNumbersFromString(newState)
                            }
                            .keyboardType(.numberPad)
                    }
                }
            },
            buttonAction: {
                if viewModel.inputValidate(goalValue: hydrationGoal), viewModel.inputValidate(goalValue: stepGoal), saveProfile() {
                    hasCompletedProfileRegister = true
                }
            }
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
