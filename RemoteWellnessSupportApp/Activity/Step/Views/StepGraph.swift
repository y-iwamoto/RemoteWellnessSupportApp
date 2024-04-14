//
//  StepGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/09.
//

import SwiftUI

struct StepGraph: View {
    @StateObject var viewModel = StepGraphViewModel()
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("アクティビティ")
                .font(.title3)
            content
                .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
                .onAppear {
                    Task {
                        await viewModel.authorizeHealthKit()
                        await viewModel.fetchStepCount()
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.targetDateSteps.isEmpty {
            Text("アクティビティデータはありません。")
            Spacer()
        } else {
            GraphValueChartView(graphValues: viewModel.targetDateSteps, timeZoneType: TimeZoneType.hour,
                                ratingYGraphValues: viewModel.stepRatingYGraphValues,
                                graphType: GraphType.step, YRateRange: viewModel.stepRateYGraphRange)
        }
    }
}

#Preview {
    StepGraph()
}
