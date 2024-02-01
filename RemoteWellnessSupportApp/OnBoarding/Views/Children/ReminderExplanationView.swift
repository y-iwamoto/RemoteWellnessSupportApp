//
//  ReminderExplanationView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct ReminderExplanationView: View {
    var body: some View {
        OnboardingContentView(imageName: "ReminderExplanation",
                              title: "ついつい忘れがちな項目についてリマインド",
                              // swiftlint:disable:next line_length
                              description: "業務に集中していると疎かになりがちな水分摂取や座りっぱなしの状況。普段から意識して行動しないと、血の巡りが悪くパフォーマンスを最大限にできません。\n\nこのアプリでリマインドを送って、自己管理していきましょう。")
    }
}

#Preview {
    ReminderExplanationView()
}
