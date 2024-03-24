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

            HStack {
                Text("水分摂取")
                // TODO: 共通化
                TextField("ml", text: $hydrationGoal)
                    .onChange(of: hydrationGoal) { _, newState in
                        let filtered = newState.filter { "0123456789".contains($0) }
                        if filtered != newState {
                            hydrationGoal = filtered
                        }
                    }
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.black).padding(10)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }

            CommonButtonView(title: "次へ進む") {
                if viewModel.inputValidate(hydrationGoal: hydrationGoal), saveProfile() {
                    hasCompletedProfileRegister = true
                }
            }
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
        .padding(.horizontal, 10)
    }
}

// #Preview {
//    GoalSettingInputView()
// }
