//
//  SelectedDateHydrationGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/29.
//

import SwiftUI

struct SelectedDateHydrationGraph: View {
    let targetDate: Date

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("\(targetDate.toString(format: "yyyy/MM/dd"))")
                    .font(.title3)
                NavigationLink(value: ConditionScreenNavigationItem.dailyHydrationList(date: targetDate)) {
                    HydrationGraph(targetDate: targetDate)
                        .frame(width: geometry.size.width * 4 / 5, height: geometry.size.height / 2)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
