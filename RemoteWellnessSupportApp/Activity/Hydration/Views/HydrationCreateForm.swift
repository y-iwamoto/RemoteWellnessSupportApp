//
//  HydrationCreateForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import SwiftUI

struct HydrationCreateForm: View {
    let targetDate: Date
    @StateObject var viewModel = HydrationEntryFormViewModel()

    init(targetDate: Date = Date()) {
        self.targetDate = targetDate
        _viewModel = StateObject(wrappedValue: HydrationEntryFormViewModel(targetDate: targetDate))
    }

    var body: some View {
        HydrationEntryForm(viewModel: viewModel, title: "水分登録")
    }
}
