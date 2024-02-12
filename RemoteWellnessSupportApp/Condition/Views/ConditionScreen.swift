//
//  ConditionScreen.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct ConditionScreen: View {
    @State private var selectedTab = ConditionTab.today

    var body: some View {
        NavigationStack {
            HStack {
                TabButton(selectedTab: $selectedTab, title: ConditionTab.today)
                TabButton(selectedTab: $selectedTab, title: ConditionTab.week)
            }
            .padding()
            .background(Color.gray.opacity(0.2))

            switch selectedTab {
            case ConditionTab.today:
                TodayCondition()
            case ConditionTab.week:
                // TODO: 現状はダミーで作成、WeekTabView作成時に対応
                Text("Week View")
            }

            Spacer()
        }
    }
}

#Preview {
    ConditionScreen()
}
