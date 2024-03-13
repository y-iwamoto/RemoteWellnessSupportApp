//
//  SelectedDatePhysicalConditionGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/11.
//

import SwiftUI

struct SelectedDatePhysicalConditionGraph: View {
    let targetDate: Date

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("\(targetDate.toString(format: "yyyy/MM/dd"))")
                    .font(.title3)
                NavigationLink(value: ActivityListDestination.dailyPhysicalConditionList(targetDate)) {
                    PhysicalConditionGraph(targetDate: targetDate)
                        .frame(width: geometry.size.width * 4 / 5, height: geometry.size.height / 2)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// #Preview {
//    SelectedDatePhysicalConditionGraph()
// }
