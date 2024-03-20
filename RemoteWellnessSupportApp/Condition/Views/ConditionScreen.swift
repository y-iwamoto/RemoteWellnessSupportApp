//
//  ConditionScreen.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct ConditionScreen: View {
    @State private var selectedTab: ConditionTab = .today
    @StateObject var router = ConditionScreenNavigationRouter()

    var body: some View {
        NavigationStack(path: $router.items) {
            HStack(spacing: StyleConst.Spacing.emptySpacing) {
                TabButton(selectedTab: $selectedTab, title: .today)
                TabButton(selectedTab: $selectedTab, title: .week)
            }
            .padding()
            .background(Color.gray.opacity(0.2))

            tabContent
                .navigationDestination(for: ConditionScreenNavigationItem.self, destination: navigationDestinationBuilder)

            Spacer()
        }
        .environmentObject(router)
    }
    
    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .today:
            TodayCondition()
        case .week:
            WeekCondition()
        }
    }
    
    @ViewBuilder
    private func navigationDestinationBuilder(item: ConditionScreenNavigationItem) -> some View {
        switch item {
        case .dailyPhysicalConditionList(let date):
            DailyPhysicalConditionList(targetDate: date)
        case .weekPhysicalConditionList:
            WeekPhysicalConditionListView()
        case .physicalConditionEditForm(let physicalCondition):
            PhysicalConditionEditForm(physicalCondition: physicalCondition)
        case .physicalConditionEntryForm:
            PhysicalConditionCreateForm()
        case .reviewEntryForm:
            ReviewEntryForm()
        case .stepEntryForm:
            StepEntryForm()
        case .hydrationEntryForm:
            HydrationEntryForm()
        case .selectedDatePhysicalConditionGraph(let targetDate):
            SelectedDatePhysicalConditionGraph(targetDate: targetDate)
        }
    }
}

#Preview {
    ConditionScreen()
}
