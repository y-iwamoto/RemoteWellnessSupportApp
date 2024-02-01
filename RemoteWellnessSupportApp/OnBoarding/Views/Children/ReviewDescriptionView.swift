//
//  ReviewDescriptionView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct ReviewDescriptionView: View {
    var body: some View {
        OnboardingContentView(imageName: "ReviewDescription",
                              title: "一日、１週間ごとの振り返り",
                              description: "一日の終わりや休日に自分のコンディションがどうだったかを振り返ってみましょう\n\n良かったことは自分を褒め、失敗したことを次に活かせるように見つめ直すと毎日、毎週を前向きに過ごせるようになります")
    }
}

#Preview {
    ReviewDescriptionView()
}
