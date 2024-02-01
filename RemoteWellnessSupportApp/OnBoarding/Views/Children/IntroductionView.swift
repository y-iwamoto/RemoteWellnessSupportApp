//
//  IntroductionView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/30.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        OnboardingContentView(imageName: "Introduction",
                              title: "ビジネスマンのコンディションを整える",
                              description: "このアプリは業務期間中のコンディションを整えて、最大のパフォーマンスを出せるようにサポートします")
    }
}

#Preview {
    IntroductionView()
}
