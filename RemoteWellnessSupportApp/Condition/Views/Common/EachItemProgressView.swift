//
//  EachItemProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/24.
//

import SwiftUI

struct EachItemProgressView: View {
    var body: some View {
        HStack(spacing: 10) {
            HydrationProgressView()
            StepProgressView()
            BreakTimeProgressView()
        }
        .padding(10)
    }
}

#Preview {
    EachItemProgressView()
}
