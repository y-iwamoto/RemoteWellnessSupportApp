//
//  WatchFeatureExplanationView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct WatchFeatureExplanationView: View {
    var body: some View {
        OnboardingContentView(imageName: "WatchFeatureExplanation",
                              title: "Apple Watchも使って手軽に計測",
                              description: "このアプリはスマートフォン以外にもApple Watchを使った簡単登録や通知受け取りができます\n\nApple Watchも上手に使い、ついつい登録忘れを防ぎましょう")
    }
}

#Preview {
    WatchFeatureExplanationView()
}
