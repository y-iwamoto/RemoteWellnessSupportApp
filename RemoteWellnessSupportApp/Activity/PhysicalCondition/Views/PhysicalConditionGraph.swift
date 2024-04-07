//
//  PhysicalConditionGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/24.
//

import Charts
import SwiftUI

struct PhysicalConditionGraph: View {
    let targetDate: Date
    @StateObject private var viewModel: PhysicalConditionGraphModel

    init(targetDate: Date) {
        self.targetDate = targetDate
        _viewModel = StateObject(wrappedValue: PhysicalConditionGraphModel(targetDate: targetDate))
    }

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("体調")
                .font(.title3)
            content
                .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
                .onAppear {
                    viewModel.fetchPhysicalConditions()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.targetDatePhysicalConditions.isEmpty {
            Text("体調のデータはありません。")
            Spacer()
        } else {
            PhysicalConditionChartView(physicalConditions: viewModel.targetDatePhysicalConditions, timeZoneType: TimeZoneType.hour)
        }
    }
}

// #Preview {
//    TodayPhysicalConditionGraph()
// }
