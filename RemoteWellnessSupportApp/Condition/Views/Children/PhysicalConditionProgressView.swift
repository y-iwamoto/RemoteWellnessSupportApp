//
//  PhysicalConditionProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/09/01.
//

import SwiftUI

struct PhysicalConditionProgressView: View {
    @StateObject var viewModel: PhysicalConditionProgressViewModel
    init(viewModel: PhysicalConditionProgressViewModel = PhysicalConditionProgressViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        PhysicalConditionCircleProgressView(progress: viewModel.physicalConditionGoalProgress,
                                            totalValue: viewModel.totalPhysicalConditionGoal,
                                            imageName: ConditionNavigationLink.ImageName.physicalConditionEntryForm.rawValue,
                                            itemValue: viewModel.currentTotalPhysicalConditionAverage,
                                            itemName: "1日の気分")
            .onAppear {
                viewModel.aggregatePhysicalCondition()
            }
    }
}

#Preview {
    PhysicalConditionProgressView()
}
