//
//  WorkTimeEditInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/03.
//

import SwiftUI

struct WorkTimeEditInputView: View {
    var profile: Profile
    @StateObject var viewModel: WorkTimeEditInputViewModel
    @EnvironmentObject var router: SettingScreenNavigationRouter

    init(profile: Profile) {
        self.profile = profile
        _viewModel = StateObject(
            wrappedValue:
            WorkTimeEditInputViewModel(profile: profile))
    }

    var body: some View {
        CommonLayoutView(
            title: "変更したい業務時間を設定して下さい",
            buttonTitle: "保存する",
            content: {
                TimePicker(timeSelection: $viewModel.workTimeFrom, label: "開始時間")
                TimePicker(timeSelection: $viewModel.workTimeTo, label: "終了時間")
            },
            buttonAction: {
                if viewModel.updateWorkTimes() {
                    router.items.removeLast()
                }
            }
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
