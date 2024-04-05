//
//  HydrationEntryForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/10.
//

import SwiftUI

struct HydrationEntryForm: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HydrationEntryFormViewModel
    let title: String

    var body: some View {
        Text(title)
            .font(.title)

        Form {
            DatePicker("日付", selection: $viewModel.selectedDateTime, displayedComponents: [.date, .hourAndMinute])
                .padding(.horizontal)

            SelectorView(selectedItem: $viewModel.selectedRating, items: HydrationRating.allCases)
                .padding(.vertical)

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
