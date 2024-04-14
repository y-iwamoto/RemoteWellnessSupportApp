//
//  WeekStepListView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/14.
//

import HealthKit
import SwiftUI

struct WeekStepListView: View {
    @StateObject var viewModel = WeekStepListViewModel()
    var body: some View {
        Text("アクティビティ一覧")
        content
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
                        Text("\(item.startDate.toString(format: "MM/dd"))")
                        Spacer()
                        StepCountTextView(stepItem: item)
                    }
                }
            }
        }
    }
}

#Preview {
    WeekStepListView()
}
