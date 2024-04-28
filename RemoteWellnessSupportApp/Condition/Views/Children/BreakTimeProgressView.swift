//
//  BreakTimeProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/27.
//

import SwiftUI

struct BreakTimeProgressView: View {
    @StateObject var viewModel = BreakTimeProgressViewModel()

    var body: some View {
        ItemCircleProgressView(progress: viewModel.breakTimeProgress,
                               totalValue: viewModel.totalBreakTimeGoal,
                               imageName: ConditionNavigationLink.ImageName.breakTime.rawValue,
                               itemValue: viewModel.currentTotalBreakTimeIntake,
                               itemName: "休憩数")
            .onAppear {
                viewModel.aggregateBreakTime()
            }
    }
}

#Preview {
    BreakTimeProgressView()
}
