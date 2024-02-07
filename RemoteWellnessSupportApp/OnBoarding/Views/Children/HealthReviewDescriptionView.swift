//
//  HealthReviewDescriptionView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct HealthReviewDescriptionView: View {
    var body: some View {
        OnboardingContentView(imageName: "HealthReviewDescription",
                              title: "自身の体調を見つめる",
                              description: "働き詰めになるとついついストレスが溜まり後から心身に影響を及ぼしがちです\n\n定期的に自分を客観視して、気持ちを吐き出しましょう\nメモ欄に書き出してもいいかもしれません")
    }
}

#Preview {
    HealthReviewDescriptionView()
}
