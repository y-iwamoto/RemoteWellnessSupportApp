//
//  GoalProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/24.
//

import SwiftUI

struct GoalProgressView: View {
    var body: some View {
        HStack(spacing: 10) {
            HydrationProgressView()
            StandHourProgressView()
            PhysicalConditionProgressView()
        }
        .padding(10)
    }
}

#Preview {
    GoalProgressView()
}
