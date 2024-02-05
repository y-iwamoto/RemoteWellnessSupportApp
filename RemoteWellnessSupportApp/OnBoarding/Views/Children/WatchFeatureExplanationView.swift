//
//  WatchFeatureExplanationView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct WatchFeatureExplanationView: View {
    @ObservedObject var viewModel: OnboardingScreenViewModel

    var body: some View {
        VStack {
            OnboardingContentView(imageName: "WatchFeatureExplanation",
                                  title: "Apple Watchも使って手軽に計測",
                                  description: "このアプリはスマートフォン以外にもApple Watchを使った簡単登録や通知受け取りができます\n\nApple Watchも上手に使い、ついつい登録忘れを防ぎましょう")
            CommonButtonView(title: "はじめる") {
                viewModel.hasCompletedOnboarding = true
            }
            .padding(.bottom, 40)
        }
    }
}
