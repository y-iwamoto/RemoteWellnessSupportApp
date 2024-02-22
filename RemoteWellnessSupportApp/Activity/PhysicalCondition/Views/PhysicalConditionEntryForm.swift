//
//  PhysicalConditionEntryForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/10.
//

import SwiftUI

struct PhysicalConditionEntryForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PhysicalConditionEntryFormViewModel()

    var body: some View {
        Text("体調登録")
            .font(.title)
        Form {
            DatePicker("日付", selection: $viewModel.selectedDateTime, displayedComponents: [.date, .hourAndMinute])
                .padding(.horizontal)

            SelectorView(selectedItem: $viewModel.selectedRating, items: PhysicalConditionRating.allCases)
                .padding(.vertical)

            StyledTextEditor(value: $viewModel.memo, placefolder: "自由に気持ちを吐き出しましょう", numberOfLines: 5)

            CommonButtonView(title: "保存する") {
                viewModel.insertPhysicalCondition(modelContext)
            }
            .onReceive(viewModel.successPublisher) { _ in
                dismiss()
            }
        }
        .environment(\.locale, .init(identifier: "ja_JP"))
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}

#Preview {
    PhysicalConditionEntryForm()
}
