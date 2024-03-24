//
//  WorkTimeInputView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/23.
//

import SwiftUI

struct WorkTimeInputView: View {
    @Binding var workTimeFrom: TimeSelection
    @Binding var workTimeTo: TimeSelection
    @StateObject var viewModel = WorkTimeInputViewModel()
    @EnvironmentObject var router: ProfileNavigationRouter

    var body: some View {
        VStack {
            Text("業務時間を設定して下さい")
                .font(.title3)

            TimePicker(timeSelection: $workTimeFrom, label: "開始時間")
            TimePicker(timeSelection: $workTimeTo, label: "終了時間")

            CommonButtonView(title: "次へ進む") {
                if viewModel.inputValidate(workTimeFrom: workTimeFrom, workTimeTo: workTimeTo) {
                    router.items.append(.restTimeInput)
                }
            }
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
        .padding(.horizontal, 20)
    }
}

// #Preview {
//    WorkTimeInputView()
// }
