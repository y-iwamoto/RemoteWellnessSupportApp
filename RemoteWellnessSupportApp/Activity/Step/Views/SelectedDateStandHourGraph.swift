//
//  SelectedDateStandHourGraph.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/09/10.
//

import SwiftUI

struct SelectedDateStandHourGraph: View {
    let targetDate: Date
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 40) {
                Text("\(targetDate.toString(format: "yyyy/MM/dd"))")
                    .font(.title3)
                StandHourGraph(targetDate: targetDate)
            }
        }
    }
}

#Preview {
    SelectedDateStandHourGraph(targetDate: Date())
}
