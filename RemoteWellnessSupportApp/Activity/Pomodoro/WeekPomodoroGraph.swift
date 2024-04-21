//
//  WeekPomodoroGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/20.
//

import SwiftUI

struct WeekPomodoroGraph: View {
    @StateObject private var viewModel = WeekPomodoroGraphViewModel()
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("タスク完了数")
                .font(.title3)
            content
                .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
                .onAppear {
                    viewModel.fetchPomodoros()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.weekPomodoros.isEmpty {
            Text("この1週間のタスク完了実績のデータはありません。")
            Spacer()
        } else {
            GraphValueChartView(graphValues: viewModel.weekPomodoros, timeZoneType: TimeZoneType.date,
                                ratingYGraphValues: viewModel.pomodoroRatingYGraphValues,
                                graphType: GraphType.pomodoro, YRateRange: viewModel.pomodoroRateYGraphRange)
        }
    }
}

#Preview {
    WeekPomodoroGraph()
}
