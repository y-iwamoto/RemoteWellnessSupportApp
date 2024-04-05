//
//  HydrationCreateForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import SwiftUI

struct HydrationCreateForm: View {
    @StateObject var viewModel = HydrationEntryFormViewModel()
    var body: some View {
        HydrationEntryForm(viewModel: viewModel, title: "水分登録")
    }
}

#Preview {
    HydrationCreateForm()
}
