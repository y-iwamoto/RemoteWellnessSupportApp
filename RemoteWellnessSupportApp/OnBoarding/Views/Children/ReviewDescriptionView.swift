//
//  ReviewDescriptionView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct ReviewDescriptionView: View {
    @StateObject var viewModel = WatchFeatureExplanationViewModel()
    var body: some View {
        VStack {
            OnboardingContentView(
                imageName: "ReviewDescription",
                title: "一日、\n一週間ごとの振り返り",
                description: "一日の終わりや休日に自分のコンディションがどうだったかを振り返ってみましょう\n\n調子が良かった時とそうでなかった時を振り返ると常にパフォーマンス高く仕事ができるようになります。"
            )
            CommonButtonView(title: "はじめる") {
                viewModel.completeOnboarding()
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    ReviewDescriptionView()
}
