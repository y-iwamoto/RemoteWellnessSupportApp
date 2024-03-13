//
//  TodayCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TodayCondition: View {
    let today = Date()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack(spacing: StyleConst.Spacing.defaultSpacing) {
                        NavigationLink(value: ActivityListDestination.dailyPhysicalConditionList(today)) {
                            PhysicalConditionGraph(targetDate: today)
                                .frame(width: geometry.size.width * 4 / 5, height: geometry.size.height / 2)
                                .padding()
                        }
                    }
                    .navigationDestination(for: ActivityListDestination.self) { _ in

                        DailyPhysicalConditionList(targetDate: Date())
                    }
                }
                ActivityEntryArea()
            }
        }
    }
}

#Preview {
    TodayCondition()
}
