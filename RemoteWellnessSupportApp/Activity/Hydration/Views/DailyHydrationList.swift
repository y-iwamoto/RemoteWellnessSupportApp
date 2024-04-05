//
//  DailyHydrationList.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/27.
//

import SwiftUI

struct DailyHydrationList: View {
    let targetDate: Date
    @StateObject var viewModel: DailyHydrationListViewModel

    init(targetDate: Date = Date()) {
        self.targetDate = targetDate
        _viewModel = StateObject(wrappedValue: DailyHydrationListViewModel(targetDate: targetDate))
    }

    var body: some View {
        Text("水分摂取一覧 \(targetDate.toString(format: "MM/dd"))")
        content
            .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
            .onAppear {
                viewModel.fetchHydrations()
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.hydrations.isEmpty {
            Text("データがありません")
            Spacer()
        } else {
            List {
                ForEach(viewModel.hydrations, id: \.self) { item in
                    HStack {
                        NavigationLink(value: ConditionScreenNavigationItem.hydrationEditForm(hydration: item)) {
                            Text(item.entryDate.toString(format: "HH:mm"))
                            Spacer()
                            if let rating = HydrationRating(rawValue: item.rating) {
                                Text("\(rating.label)")
                                Image(systemName: rating.imageName)
                            } else {
                                Text("評価なし")
                            }
                        }
                    }
                }
                .onDelete(perform: remove)
            }
        }
    }

    private func remove(index: IndexSet) {
        viewModel.deleteHydration(at: index)
    }
}
