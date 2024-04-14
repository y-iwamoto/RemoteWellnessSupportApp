//
//  DailyStepList.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import HealthKit
import SwiftUI

struct DailyStepList: View {
    let targetDate: Date
    @StateObject var viewModel: DailyStepListViewModel

    init(targetDate: Date = Date()) {
        self.targetDate = targetDate
        _viewModel = StateObject(wrappedValue: DailyStepListViewModel(targetDate: targetDate))
    }

    var body: some View {
        Text("アクティビティ一覧 \(targetDate.toString(format: "MM/dd"))")
        content
            .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
            .onAppear {
                Task {
                    await viewModel.fetchSteps()
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.steps.isEmpty {
            Text("データがありません")
            Spacer()
        } else {
            List {
                ForEach(viewModel.steps, id: \.self) { item in
                    HStack {
                        Text("\(item.startDate.toString(format: "HH:mm"))~\(item.endDate.toString(format: "HH:mm"))")
                        Spacer()
                        StepCountTextView(stepItem: item)
                    }
                }
            }
        }
    }
}

#Preview {
    DailyStepList()
}
