//
//  ConditionScreen.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct ConditionScreen: View {
    @State private var selectedTab: ConditionTab = .today

    var body: some View {
        NavigationStack {
            HStack(spacing: StyleConst.Spacing.emptySpacing) {
                TabButton(selectedTab: $selectedTab, title: .today)
                TabButton(selectedTab: $selectedTab, title: .week)
            }
            .padding()
            .background(Color.gray.opacity(0.2))

            switch selectedTab {
            case .today:
                TodayCondition()
            case .week:
                WeekCondition()
            }

            Spacer()
        }
    }
}

#Preview {
    ConditionScreen()
}
