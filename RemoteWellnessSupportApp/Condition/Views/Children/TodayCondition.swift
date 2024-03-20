//
//  TodayCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TodayCondition: View {
    @State private var navigationTarget: ActivityListDestination?
    @EnvironmentObject var router: ConditionScreenNavigationRouter
    @AppStorage("notificationIdentifier") var notificationIdentifier: String?

    let today = Date()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack(spacing: StyleConst.Spacing.defaultSpacing) {
                        NavigationLink(value: ConditionScreenNavigationItem.dailyPhysicalConditionList(date: today)) {
                            PhysicalConditionGraph(targetDate: today)
                                .frame(width: geometry.size.width * 4 / 5, height: geometry.size.height / 2)
                                .padding()
                        }
                    }
                }
                ActivityEntryArea()
            }
            .onChange(of: notificationIdentifier) {
                if notificationIdentifier != nil {
                    router.items.append(.physicalConditionEntryForm)
                }
            }
        }
    }
}

#Preview {
    TodayCondition()
}
