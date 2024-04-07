//
//  HydrationGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/26.
//

import Charts
import SwiftUI

struct HydrationGraph: View {
    let targetDate: Date
    @StateObject private var viewModel: HydrationGraphViewModel

    init(targetDate: Date) {
        self.targetDate = targetDate
        _viewModel = StateObject(wrappedValue: HydrationGraphViewModel(targetDate: targetDate))
    }

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("水分摂取量")
                .font(.title3)
            content
                .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
                .onAppear {
                    viewModel.fetchHydrations()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.targetDateHydrations.isEmpty {
            Text("水分摂取のデータはありません。")
            Spacer()
        } else {
            GraphValueChartView(graphValues: viewModel.targetDateHydrations, timeZoneType: TimeZoneType.hour,
                                ratingYGraphValues: viewModel.hydrationRatingYGraphValues,
                                graphType: GraphType.hydration, YRateRange: viewModel.hydrationRateYGraphRange)
        }
    }
}
