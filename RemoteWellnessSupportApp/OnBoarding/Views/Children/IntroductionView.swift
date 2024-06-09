//
//  IntroductionView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/30.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        VStack {
            OnboardingContentView(
                imageName: "Introduction",
                title: "ビジネスマンのコンディションを整える",
                description: "このアプリは業務期間中のコンディションを整えて、最大のパフォーマンスを出せるようにサポートします。\n\n具体的に「水分摂取」、「座り過ぎの状況」、「定期的な休憩の有無」を管理します"
            )
            CommonButtonView(title: "") {}
                .opacity(0)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    IntroductionView()
}
