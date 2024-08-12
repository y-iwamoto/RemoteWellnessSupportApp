//
//  ProfileScreen.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/22.
//

import SwiftUI

struct ProfileScreen: View {
    @StateObject var router = ProfileNavigationRouter()
    @StateObject var viewModel = ProfileScreenViewModel()

    var body: some View {
        NavigationStack(path: $router.items) {
            WorkDaySelectView(workDays: $viewModel.workDays)
                .navigationDestination(for: ProfileNavigationItem.self,
                                       destination: navigationDestinationBuilder)
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
        .environmentObject(router)
    }

    @ViewBuilder
    private func navigationDestinationBuilder(item: ProfileNavigationItem) -> some View {
        switch item {
        case .workDaySelect:
            WorkDaySelectView(workDays: $viewModel.workDays)
        case .workTimeInput:
            WorkTimeInputView(workTimeFrom: $viewModel.workTimeFrom, workTimeTo: $viewModel.workTimeTo)
        case .restTimeInput:
            RestTimeInputView(restTimePeriodSections: $viewModel.restTimePeriodSections)
        case .goalSettingInput:
            GoalSettingInputView(hydrationGoal: $viewModel.hydrationGoal, stepGoal: $viewModel.stepGoal) {
                viewModel.saveProfile()
            }
        }
    }
}

#Preview {
    ProfileScreen()
}
