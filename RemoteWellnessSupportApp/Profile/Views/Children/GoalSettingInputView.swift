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
    @AppStorage(Const.AppStatus.hasCompletedProfileRegister) var hasCompletedProfileRegister = false

    var saveProfile: () -> Bool

    var body: some View {
        VStack {
            Text("1時間あたりの目標値を設定して下さい")
                .font(.title3)
                .padding(.bottom, 50)

            HStack {
                Text("水分摂取")
                TextInput(labelName: "ml", value: $hydrationGoal)
                    .onChange(of: hydrationGoal) { _, newState in
                        hydrationGoal = viewModel.processHydrationGoalChange(newState)
                    }
                    .keyboardType(.numberPad)
            }
            Spacer()
            CommonButtonView(title: "次へ進む") {
                if viewModel.inputValidate(hydrationGoal: hydrationGoal), saveProfile() {
                    hasCompletedProfileRegister = true
                }
            }
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
        .padding(.horizontal, 10)
        .padding(.bottom, 70)
        .padding(.top, 30)
    }
}

// #Preview {
//    GoalSettingInputView()
// }
