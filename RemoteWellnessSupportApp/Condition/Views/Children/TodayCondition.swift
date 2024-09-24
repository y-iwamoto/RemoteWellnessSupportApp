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
        GeometryReader { _ in
            ZStack {
                ScrollView {
                    VStack(spacing: StyleConst.Spacing.defaultSpacing) {
                        WorkModeMessageView()
                    }
                    VStack(spacing: StyleConst.Spacing.defaultSpacing) {
                        GoalProgressView()
                    }
                }
                ActivityEntryArea(targetDate: today)
            }
            .onChange(of: notificationIdentifier) {
                if let identifier = notificationIdentifier.flatMap(ReminderType.fromIdentifier) {
                    switch identifier {
                    case .hydration:
                        router.items.append(.hydrationEntryForm(date: today))
                    case .physicalCondition:
                        router.items.append(.physicalConditionEntryForm(date: today))
                    }
                }
            }
        }
    }
}

#Preview {
    TodayCondition()
}
