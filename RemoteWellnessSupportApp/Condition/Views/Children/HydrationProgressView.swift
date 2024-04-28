//
//  HydrationProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/25.
//

import SwiftUI

struct HydrationProgressView: View {
    @StateObject var viewModel = HydrationProgressViewModel()

    var body: some View {
        ItemCircleProgressView(progress: viewModel.hydrationGoalProgress,
                               totalValue: viewModel.totalHydrationGoal,
                               imageName: ConditionNavigationLink.ImageName.hydrationEntryForm.rawValue,
                               itemValue: viewModel.currentTotalHydrationIntake,
                               itemName: "水分摂取量")
            .onAppear {
                viewModel.aggregateHydration()
            }
    }
}

#Preview {
    HydrationProgressView()
}
