//
//  ConditionScreen.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct ConditionScreen: View {
    @State private var selectedTab = ConditionTabConst.LabelTitle.today

    var body: some View {
        NavigationStack {
            HStack {
                TabButton(title: ConditionTabConst.LabelTitle.today, selectedTab: $selectedTab)
                TabButton(title: ConditionTabConst.LabelTitle.week, selectedTab: $selectedTab)
            }
            .padding()
            .background(Color.gray.opacity(0.2))

            switch selectedTab {
            case ConditionTabConst.LabelTitle.today:
                TodayCondition()
            case ConditionTabConst.LabelTitle.week:
                // TODO: 現状はダミーで作成、WeekTabView作成時に対応
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
