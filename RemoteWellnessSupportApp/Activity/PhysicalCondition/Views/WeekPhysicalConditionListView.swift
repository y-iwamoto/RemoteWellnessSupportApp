//
//  WeekPhysicalConditionListView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/10.
//

import SwiftUI

struct WeekPhysicalConditionListView: View {
    @ObservedObject var viewModel: WeekPhysicalConditionListViewModel

    init(viewModel: WeekPhysicalConditionListViewModel = WeekPhysicalConditionListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text("体調一覧")
        content
            .navigationDestination(for: DateWithPhysicalCondition.self) { dateWithPhysicalCondition in
                SelectedDatePhysicalConditionGraph(targetDate: dateWithPhysicalCondition.date)
            }
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
                        NavigationLink(value: item) {
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
