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
    @EnvironmentObject var router: ProfileNavigationRouter

    var body: some View {
        CommonLayoutView(
            title: "あなたの名前について教えて下さい",
            buttonTitle: "次へ進む",
            content: {
                TextInput(labelName: "ニックネーム", value: $nickname)
            },
            buttonAction: {
                if viewModel.inputValidate(nickname: nickname) {
                    router.items.append(.workDaySelect)
                }
            },
            isFirstView: true
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
