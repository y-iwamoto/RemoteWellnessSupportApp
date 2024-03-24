//
//  NicknameInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/22.
//

import SwiftUI

struct NicknameInputView: View {
    @Binding var nickname: String
    @StateObject var viewModel = NicknameInputViewModel()
    @EnvironmentObject private var router: ProfileNavigationRouter

    var body: some View {
        VStack {
            VStack(spacing: 50) {
                Text("あなたの名前について教えて下さい")
                    .font(.title3)
                TextInput(labelName: "ニックネーム", value: $nickname)
            }
            Spacer()
            CommonButtonView(title: "次へ進む") {
                if viewModel.inputValidate(nickname: nickname) {
                    router.items.append(.workDaySelect)
                }
            }
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
        .padding(.horizontal, 10)
        .padding(.vertical, 70)
    }
}

#Preview {
    NicknameInputView(nickname: .constant("test"))
}
