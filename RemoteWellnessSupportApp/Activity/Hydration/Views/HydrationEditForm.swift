//
//  HydrationEditForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/27.
//

import SwiftUI

struct HydrationEditForm: View {
    var hydration: Hydration
    @StateObject var viewModel: HydrationEntryFormViewModel

    init(hydration: Hydration) {
        self.hydration = hydration
        _viewModel = StateObject(wrappedValue:
            HydrationEntryFormViewModel(action: .update, hydration: hydration, targetDate: hydration.entryDate))
    }

    var body: some View {
        HydrationEntryForm(viewModel: viewModel, title: "水分摂取編集")
    }
}
