//
//  PhysicalConditionReminderEditView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/07.
//

import SwiftUI

struct PhysicalConditionReminderEditView: View {
    var reminder: PhysicalConditionReminder
    @StateObject var viewModel: PhysicalConditionReminderEditViewModel
    @EnvironmentObject var router: SettingScreenNavigationRouter

    init(reminder: PhysicalConditionReminder) {
        self.reminder = reminder
        _viewModel = StateObject(wrappedValue: PhysicalConditionReminderEditViewModel(reminder: reminder))
    }

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

                    tabContent
                        .frame(height: geometry.size.height * 0.3)
                }
                Spacer()

                CommonButtonView(title: "保存する") {
                    Task {
                        if await viewModel.updatePhysicalConditionReminder() {
                            router.items.removeLast()
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            .padding(.horizontal, 10)
        }
        .modifier(ErrorAlertModifier(isErrorAlert: $viewModel.isErrorAlert, errorMessage: $viewModel.errorMessage))
    }

    @ViewBuilder
    private var tabContent: some View {
        switch viewModel.selectedTab {
        case .repeating:
            IntervalTimeSelectView(selectedHour: $viewModel.selectedHour, selectedMinute: $viewModel.selectedMinute)
        case .scheduled:
            ScheduleTimeSelectView(timeSelections: $viewModel.scheduledTimeSelections)
        }
    }
}
