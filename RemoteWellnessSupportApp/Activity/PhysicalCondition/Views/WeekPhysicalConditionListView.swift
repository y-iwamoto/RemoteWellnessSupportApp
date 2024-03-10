//
//  WeekPhysicalConditionListView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/10.
//

import SwiftUI

struct WeekPhysicalConditionListView: View {
    @StateObject var viewModel = WeekPhysicalConditionListViewModel()

    var body: some View {
        Text("体調一覧")
        content
            .onAppear {
                viewModel.fetchDatesWithPhysicalCondition()
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.dateWithPhysicalConditions.isEmpty {
            Text("データがありません")
            Spacer()
        } else {
            List {
                ForEach(viewModel.dateWithPhysicalConditions, id: \.self) { item in
                    HStack {
                        // TODO: 後でnavigation対応を実施
                        // NavigationLink(value: item) {
                        Text(item.date)
                        Spacer()
                        // }
                    }
                }
            }
        }
    }
}

#Preview {
    WeekPhysicalConditionListView()
}
