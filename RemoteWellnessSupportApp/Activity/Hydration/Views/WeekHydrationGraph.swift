//
//  WeekHydrationGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/28.
//

import SwiftUI

struct WeekHydrationGraph: View {
    @StateObject private var viewModel = WeekHydrationGraphViewModel()
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("水分摂取")
                .font(.title3)
            content
                .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
                .onAppear {
                    viewModel.fetchWeekHydrations()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.weekHydrations.isEmpty {
            Text("この1週間の水分摂取のデータはありません。")
            Spacer()
        } else {
            GraphValueChartView(graphValues: viewModel.weekHydrations, timeZoneType: TimeZoneType.date,
                                ratingYGraphValues: viewModel.hydrationRatingYGraphValues,
                                graphType: GraphType.hydration, YRateRange: viewModel.hydrationRateYGraphRange)
        }
    }
}

#Preview {
    WeekHydrationGraph()
}
