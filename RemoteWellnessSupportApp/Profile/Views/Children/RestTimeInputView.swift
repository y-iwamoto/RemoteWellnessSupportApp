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
    @EnvironmentObject private var router: ProfileNavigationRouter

    var body: some View {
        VStack {
            Text("休憩時間を設定して下さい")
                .font(.title3)
            // TODO: 共通化
            List {
                ForEach(restTimePeriodSections.indices, id: \.self) { index in
                    VStack {
                        TimePicker(timeSelection: $restTimePeriodSections[index].fromTime, label: "休憩開始時間")

                        TimePicker(timeSelection: $restTimePeriodSections[index].toTime, label: "休憩終了時間")
                    }
                }
                .onDelete(perform: removeTimeSelection)

                Button(action: addTimeSelection) {
                    Label("追加", systemImage: "plus.circle.fill")
                }
            }
            .listStyle(PlainListStyle())

            CommonButtonView(title: "次へ進む") {
                if viewModel.inputValidate(restTimePeriodSections: restTimePeriodSections) {
                    router.items.append(.goalSettingInput)
                }
            }
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }

    private func addTimeSelection() {
        restTimePeriodSections.append(RestTimePeriodSection(fromTime: TimeSelection(), toTime: TimeSelection()))
    }

    private func removeTimeSelection(at offsets: IndexSet) {
        restTimePeriodSections.remove(atOffsets: offsets)
    }
}

// #Preview {
//    RestTimeInputView()
// }
