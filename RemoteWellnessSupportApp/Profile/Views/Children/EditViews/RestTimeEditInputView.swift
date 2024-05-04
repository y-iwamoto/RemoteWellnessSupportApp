//
//  RestTimeEditInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/04.
//

import SwiftUI

struct RestTimeEditInputView: View {
    var profile: Profile
    @StateObject var viewModel: RestTimeEditInputViewModel
    @EnvironmentObject var router: SettingScreenNavigationRouter

    init(profile: Profile) {
        self.profile = profile
        _viewModel = StateObject(
            wrappedValue:
            RestTimeEditInputViewModel(profile: profile))
    }

    var body: some View {
        CommonLayoutView(
            title: "変更したい休憩時間を設定して下さい",
            buttonTitle: "保存する",
            content: {
                TimeSelectionListView(
                    items: $viewModel.restTimePeriodSections,
                    contentView: { item in
                        VStack {
                            TimePicker(timeSelection: item.fromTime, label: "休憩開始時間")
                            TimePicker(timeSelection: item.toTime, label: "休憩終了時間")
                        }
                    },
                    addItem: { viewModel.restTimePeriodSections.append(RestTimePeriodSection(fromTime: TimeSelection(), toTime: TimeSelection())) },
                    removeItem: { viewModel.restTimePeriodSections.remove(atOffsets: $0) }
                )
            },
            buttonAction: {
                if viewModel.updateRestTimes() {
                    router.items.removeLast()
                }
            }
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
