//
//  PhysicalConditionEditForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/03.
//

import SwiftUI

struct PhysicalConditionEditForm: View {
    var physicalCondition: PhysicalCondition
    @StateObject var viewModel: PhysicalConditionEntryFormViewModel

    init(physicalCondition: PhysicalCondition) {
        self.physicalCondition = physicalCondition
        _viewModel = StateObject(
            wrappedValue:
            PhysicalConditionEntryFormViewModel(formAction: .update,
                                                physicalCondition: physicalCondition,
                                                targetDate: physicalCondition.entryDate))
    }

    var body: some View {
        PhysicalConditionEntryForm(viewModel: viewModel, title: "体調編集")
    }
}

// #Preview {
//    PhysicalConditionEditForm()
// }
