//
//  PhysicalConditionCreateForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/05.
//

import SwiftUI

struct PhysicalConditionCreateForm: View {
    let targetDate: Date
    @StateObject var viewModel = PhysicalConditionEntryFormViewModel()

    init(targetDate: Date = Date()) {
        self.targetDate = targetDate
        _viewModel = StateObject(wrappedValue: PhysicalConditionEntryFormViewModel(targetDate: targetDate))
    }

    var body: some View {
        PhysicalConditionEntryForm(viewModel: viewModel, title: "体調登録")
    }
}
