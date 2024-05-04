//
//  NicknameEditInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/01.
//

import SwiftUI

struct NicknameEditInputView: View {
    var profile: Profile
    @StateObject var viewModel: NicknameEditInputViewModel
    @EnvironmentObject var router: SettingScreenNavigationRouter

    init(profile: Profile) {
        self.profile = profile
        _viewModel = StateObject(
            wrappedValue:
            NicknameEditInputViewModel(profile: profile))
    }

    var body: some View {
        CommonLayoutView(
            title: "変更したい名前を入力して下さい",
            buttonTitle: "保存する",
            content: {
                TextInput(labelName: "ニックネーム", value: $viewModel.nickname)
            },
            buttonAction: {
                if viewModel.updateNickname() {
                    router.items.removeLast()
                }
            },
            isFirstView: true
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
