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
                        NavigationLink(value: ConditionScreenNavigationItem.selectedDatePhysicalConditionGraph(targetDate: item.date)) {
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
    WeekPhysicalConditionListView()
}
