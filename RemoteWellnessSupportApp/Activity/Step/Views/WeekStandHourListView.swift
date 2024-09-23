//
//  WeekStandHourListView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import HealthKit
import SwiftUI

struct WeekStandHourListView: View {
    @StateObject var viewModel = WeekStanHourListViewModel()
    var body: some View {
        Text("アクティビティ一覧")
        content
            .onAppear {
                Task {
                    await viewModel.fetchStandHours()
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.weekDates.isEmpty {
            Text("データがありません")
            Spacer()
        } else {
            List {
                ForEach(viewModel.weekDates, id: \.self) { weekDate in
                    HStack {
                        NavigationLink(value: ConditionScreenNavigationItem.selectedDateStandHourGraph(targetDate: weekDate)) {
                            Text("\(weekDate.toString(format: "MM/dd"))")
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WeekStandHourListView()
}
