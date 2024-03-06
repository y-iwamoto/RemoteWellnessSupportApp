//
//  TodayCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TodayCondition: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack(spacing: StyleConst.Spacing.defaultSpacing) {
                        TodayPhysicalConditionGraph()
                            .frame(width: geometry.size.width * 4 / 5, height: geometry.size.height / 2)
                            .padding()
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
