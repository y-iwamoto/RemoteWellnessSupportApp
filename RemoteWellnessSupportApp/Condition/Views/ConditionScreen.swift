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
        VStack {
            // タブバー
            HStack {
                TabButton(title: "Today", selectedTab: $selectedTab)
                TabButton(title: "Week", selectedTab: $selectedTab)
            }
            .padding()
            .background(Color.gray.opacity(0.2))

            // 選択されたタブに応じて表示するビュー
            switch selectedTab {
            case "Today":
                Text("Today View")
            case "Week":
                Text("Week View")
            default:
                Text("Today View")
            }

            Spacer()
        }
    }
}

#Preview {
    ConditionScreen()
}
