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
                    VStack {
                        ForEach(0 ..< 3) { index in
                            Text("Dummy Graph Area \(index + 1)")
                                .frame(width: geometry.size.width, height: 400)
                                .background(Color.pink.opacity(0.2))
                        }
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
