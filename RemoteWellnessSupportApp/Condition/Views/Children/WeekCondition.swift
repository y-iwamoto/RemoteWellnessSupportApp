//
//  WeekCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/09.
//

import SwiftUI

struct WeekCondition: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack(spacing: StyleConst.Spacing.defaultSpacing) {
                        NavigationLink(value: ConditionScreenNavigationItem.weekPhysicalConditionList) {
                            WeekPhysicalConditionGraph()
                                .frame(width: geometry.size.width * 4 / 5, height: geometry.size.height / 2)
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    WeekCondition()
}
