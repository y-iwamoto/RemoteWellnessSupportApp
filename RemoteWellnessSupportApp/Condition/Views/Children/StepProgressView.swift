//
//  StepProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/27.
//

import SwiftUI

struct StepProgressView: View {
    @StateObject var viewModel = StepProgressViewModel()

    var body: some View {
        ItemCircleProgressView(progress: viewModel.stepGoalProgress,
                               totalValue: viewModel.totalStepGoal,
                               imageName: ConditionNavigationLink.ImageName.stepEntryForm.rawValue,
                               itemValue: viewModel.currentTotalStepIntake,
                               itemName: "歩数")
            .onAppear {
                viewModel.aggregateStep()
            }
    }
}

#Preview {
    StepProgressView()
}
