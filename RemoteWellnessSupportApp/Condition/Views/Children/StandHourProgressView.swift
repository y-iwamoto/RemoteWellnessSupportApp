//
//  StandHourProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/27.
//

import SwiftUI

struct StandHourProgressView: View {
    @StateObject var viewModel = StandHourProgressViewModel()

    var body: some View {
        StandingHourCircleProgressView(progress: viewModel.standHourGoalProgress,
                                       totalValue: viewModel.totalStandHourGoal,
                                       imageName: ConditionNavigationLink.ImageName.stepEntryForm.rawValue,
                                       itemValue: viewModel.currentTotalStandHourIntake,
                                       itemName: "立ち上がり状態")
            .onAppear {
                viewModel.aggregateStep()
            }
    }
}

#Preview {
    StandHourProgressView()
}
