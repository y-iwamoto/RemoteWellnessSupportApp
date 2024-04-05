//
//  WeekPhysicalConditionGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/09.
//

import SwiftUI

struct WeekPhysicalConditionGraph: View {
    @StateObject private var viewModel = WeekPhysicalConditionGraphViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("体調")
                .font(.title3)
            content
                .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
                .onAppear {
                    viewModel.fetchWeekPhysicalConditions()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.weekPhysicalConditions.isEmpty {
            Text("この1週間の体調のデータはありません。")
            Spacer()
        } else {
            PhysicalConditionChartView(physicalConditions: viewModel.weekPhysicalConditions, timeZoneType: TimeZoneType.date)
        }
    }
}

#Preview {
    WeekPhysicalConditionGraph()
}
