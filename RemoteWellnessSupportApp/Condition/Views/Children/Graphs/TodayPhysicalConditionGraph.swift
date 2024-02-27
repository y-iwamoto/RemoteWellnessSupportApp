//
//  TodayPhysicalConditionGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/24.
//

import Charts
import SwiftUI

struct TodayPhysicalConditionGraph: View {
    @StateObject private var viewModel = TodayPhysicalConditionGraphViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("体調")
                .font(.title3)
            content
                .onAppear {
                    viewModel.fetchPhysicalConditions()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.todayPhysicalConditions.isEmpty {
            Text("本日の体調のデータはありません。")
            Spacer()
        } else {
            PhysicalConditionChartView(physicalConditions: viewModel.todayPhysicalConditions, timeZoneType: TimeZoneType.hour)
        }
    }
}

#Preview {
    TodayPhysicalConditionGraph()
}
