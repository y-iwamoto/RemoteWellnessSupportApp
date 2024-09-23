//
//  StandHourGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/09.
//

import SwiftUI

struct StandHourGraph: View {
    let targetDate: Date
    @StateObject var viewModel: StandStatusGraphViewModel

    init(targetDate: Date) {
        self.targetDate = targetDate
        _viewModel = StateObject(wrappedValue: StandStatusGraphViewModel(targetDate: targetDate))
    }

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("アクティビティ")
                .font(.title3)
            content
                .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
                .onAppear {
                    Task {
                        await viewModel.fetchStandHour()
                    }
                }
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.targetDateStandStatus.isEmpty {
            VStack(alignment: .center) {
                Text("アクティビティデータはありません。")
            }
        } else {
            StandHpurGraphValueChartView(graphValues: viewModel.targetDateStandStatus, timeZoneType: TimeZoneType.hour,
                                         ratingYGraphValues: viewModel.standStatusRatingYGraphValues,
                                         graphType: GraphType.step)
        }
    }
}

#Preview {
    StandHourGraph(targetDate: Date())
}
