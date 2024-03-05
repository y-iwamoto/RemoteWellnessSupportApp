//
//  PhysicalConditionEditForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/03.
//

import SwiftUI

struct PhysicalConditionEditForm: View {
    var physicalCondition: PhysicalCondition
    @ObservedObject var viewModel: PhysicalConditionEntryFormViewModel

    init(physicalCondition: PhysicalCondition) {
        self.physicalCondition = physicalCondition
        viewModel = PhysicalConditionEntryFormViewModel(formAction: FormAction.update, physicalCondition: physicalCondition)
    }

    var body: some View {
        PhysicalConditionEntryForm(viewModel: viewModel, title: "体調編集")
    }
}

// #Preview {
//    PhysicalConditionEditForm()
// }
