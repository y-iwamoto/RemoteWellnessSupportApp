//
//  RestTimeInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import SwiftUI

struct RestTimeInputView: View {
    @Binding var restTimePeriodSections: [RestTimePeriodSection]
    @StateObject var viewModel = RestTimeInputViewModel()
    @EnvironmentObject var router: ProfileNavigationRouter

    var body: some View {
        CommonLayoutView(
            title: "休憩時間を設定して下さい",
            buttonTitle: "次へ進む",
            content: {
                TimeSelectionListView(
                    items: $restTimePeriodSections,
                    contentView: { item in
                        VStack {
                            TimePicker(timeSelection: item.fromTime, label: "休憩開始時間")
                            TimePicker(timeSelection: item.toTime, label: "休憩終了時間")
                        }
                    },
                    addItem: { restTimePeriodSections.append(RestTimePeriodSection(fromTime: TimeSelection(), toTime: TimeSelection())) },
                    removeItem: { restTimePeriodSections.remove(atOffsets: $0) }
                )
            },
            buttonAction: {
                if viewModel.inputValidate(restTimePeriodSections: restTimePeriodSections) {
                    router.items.append(.goalSettingInput)
                }
            }
        )
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
