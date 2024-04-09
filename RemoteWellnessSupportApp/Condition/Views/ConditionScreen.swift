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

    // TODO: TodayConditionとWeekConditionにそれぞれnavigationを移動。また各登録画面についてはそれぞれnavigation持たせるべき
    // swiftlint:disable cyclomatic_complexity
    @ViewBuilder
    private func navigationDestinationBuilder(item: ConditionScreenNavigationItem) -> some View {
        switch item {
        case let .dailyPhysicalConditionList(date):
            DailyPhysicalConditionList(targetDate: date)
        case let .dailyHydrationList(date):
            DailyHydrationList(targetDate: date)
        case .weekPhysicalConditionList:
            WeekPhysicalConditionListView()
        case .weekHydrationList:
            WeekHydrationListView()
        case let .physicalConditionEditForm(physicalCondition):
            PhysicalConditionEditForm(physicalCondition: physicalCondition)
        case let .hydrationEditForm(hydration):
            HydrationEditForm(hydration: hydration)
        case let .physicalConditionEntryForm(date):
            PhysicalConditionCreateForm(targetDate: date)
        case .reviewEntryForm:
            ReviewEntryForm()
        case .stepEntryForm:
            StepEntryForm()
        case let .hydrationEntryForm(date):
            HydrationCreateForm(targetDate: date)
        case let .selectedDatePhysicalConditionGraph(targetDate):
            SelectedDatePhysicalConditionGraph(targetDate: targetDate)
        case let .selectedDateHydrationGraph(targetDate):
            SelectedDateHydrationGraph(targetDate: targetDate)
        }
    }
    // swiftlint:enable cyclomatic_complexity
}

#Preview {
    ConditionScreen()
}
