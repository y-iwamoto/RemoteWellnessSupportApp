//
//  WeekStandHourGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/11.
//

import SwiftUI

struct WeekStandHourGraph: View {
    @StateObject var viewModel = WeekStandHourGraphViewModel()
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("アクティビティ")
                .font(.title3)
            content
                .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
                .onAppear {
                    Task {
                        await viewModel.fetchStepCount()
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.weekSteps.isEmpty {
            Text("この1週間の歩行データはありません。")
            Spacer()
        } else {
            GraphValueChartView(graphValues: viewModel.weekSteps, timeZoneType: TimeZoneType.date,
                                ratingYGraphValues: viewModel.stepRatingYGraphValues,
                                graphType: GraphType.step, YRateRange: viewModel.stepRateYGraphRange)
        }
    }
}

#Preview {
    WeekStandHourGraph()
}
