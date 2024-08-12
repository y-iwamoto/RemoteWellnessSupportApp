//
//  ReminderExplanationView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct ReminderExplanationView: View {
    var body: some View {
        VStack {
            OnboardingContentView(
                imageName: "ReminderExplanationIos",
                title: "忘れがちな項目をリマインドします",
                // swiftlint:disable:next line_length
                description: "仕事に集中していると、水分補給や休憩を忘れがちになり、長時間座り続けてしまうことが多いです。これに気を付けないと血行が悪くなり、最大限のパフォーマンスを発揮できません。\n\nこのアプリを使って、リマインダーを設定し、自己管理をしていきましょう。"
            )
            CommonButtonView(title: "") {}
                .opacity(0)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    ReminderExplanationView()
}
