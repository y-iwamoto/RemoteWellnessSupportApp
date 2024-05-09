//
//  PhysicalConditionReminderBaseView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/09.
//

import SwiftUI

struct PhysicalConditionReminderBaseView<ViewModel: ReminderViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    var buttonTitle: String
    var buttonAction: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                Text("体調リマインドについて設定して下さい")
                    .font(.title)
                    .padding(.top, 10)

                Toggle(isOn: $viewModel.isReminderActive) {
                    Text("通知設定の有無")
                }
                .padding()

                if viewModel.isReminderActive {
                    HStack(spacing: StyleConst.Spacing.emptySpacing) {
                        TabButton(selectedTab: $viewModel.selectedTab, title: .repeating)
                        TabButton(selectedTab: $viewModel.selectedTab, title: .scheduled)
                    }
                    .padding()

                    tabContent(geometry: geometry)
                }
                Spacer()

                CommonButtonView(title: buttonTitle, action: buttonAction)
                    .padding(.bottom, 50)
            }
            .padding(.horizontal, 10)
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }

    @ViewBuilder
    private func tabContent(geometry _: GeometryProxy) -> some View {
        switch viewModel.selectedTab {
        case .repeating:
            IntervalTimeSelectView(selectedHour: $viewModel.selectedHour, selectedMinute: $viewModel.selectedMinute)
        case .scheduled:
            ScheduleTimeSelectView(timeSelections: $viewModel.scheduledTimeSelections)
        }
    }
}
