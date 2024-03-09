//
//  PhysicalConditionEntryForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/10.
//

import SwiftUI

struct PhysicalConditionEntryForm: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PhysicalConditionEntryFormViewModel
    let title: String

    var body: some View {
        Text(title)
            .font(.title)
        Form {
            DatePicker("日付", selection: $viewModel.selectedDateTime, displayedComponents: [.date, .hourAndMinute])
                .padding(.horizontal)

            SelectorView(selectedItem: $viewModel.selectedRating, items: PhysicalConditionRating.allCases)
                .padding(.vertical)

            StyledTextEditor(value: $viewModel.memo, placeholder: "自由に気持ちを吐き出しましょう", numberOfLines: 5)

            CommonButtonView(title: "保存する") {
                viewModel.formAction()
            }
            .onChange(of: viewModel.isFormSubmitted) {
                guard viewModel.isFormSubmitted else { return }
                dismiss()
            }
        }
        .environment(\.locale, .init(identifier: "ja_JP"))
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }
}
