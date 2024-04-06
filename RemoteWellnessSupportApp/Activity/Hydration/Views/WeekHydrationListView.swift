//
//  WeekHydrationListView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/29.
//

import SwiftUI

struct WeekHydrationListView: View {
    @StateObject var viewModel = WeekHydrationListViewModel()

    var body: some View {
        Text("水分摂取一覧")
        content
            .onAppear {
                viewModel.fetchDateWithHydration()
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.dateWithHydrations.isEmpty {
            Text("データがありません")
            Spacer()
        } else {
            List {
                ForEach(viewModel.dateWithHydrations, id: \.self) { item in
                    HStack {
                        NavigationLink(value: ConditionScreenNavigationItem.selectedDateHydrationGraph(targetDate: item.date)) {
                            Text(item.date.toString(format: "yyyy/MM/dd"))
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WeekHydrationListView()
}
