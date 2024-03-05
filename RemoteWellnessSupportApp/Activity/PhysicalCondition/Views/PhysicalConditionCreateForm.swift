//
//  PhysicalConditionCreateForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/05.
//

import SwiftUI

struct PhysicalConditionCreateForm: View {
    @StateObject var viewModel = PhysicalConditionEntryFormViewModel()

    var body: some View {
        PhysicalConditionEntryForm(viewModel: viewModel, title: "体調登録")
    }
}

#Preview {
    PhysicalConditionCreateForm()
}
