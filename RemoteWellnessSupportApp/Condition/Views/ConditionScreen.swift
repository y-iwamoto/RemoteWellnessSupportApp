//
//  ConditionScreen.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct ConditionScreen: View {
    @State private var selectedTab = "Today"

    var body: some View {
        NavigationStack {
            HStack {
                TabButton(title: "Today", selectedTab: $selectedTab)
                TabButton(title: "Week", selectedTab: $selectedTab)
            }
            .padding()
            .background(Color.gray.opacity(0.2))

            switch selectedTab {
            case "Today":
                TodayCondition()
            case "Week":
                Text("Week View")
            default:
                TodayCondition()
            }

            Spacer()
        }
    }
}

#Preview {
    ConditionScreen()
}
