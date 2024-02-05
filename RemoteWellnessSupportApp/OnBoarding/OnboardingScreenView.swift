//
//  OnboardingScreenView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct OnboardingScreenView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @State private var selection = OnBoardingTab.introduction

    var body: some View {
        VStack {
            TabView(selection: $selection) {
                IntroductionView()
                    .tag(OnBoardingTab.introduction.rawValue)
                ReminderExplanationView()
                    .tag(OnBoardingTab.reminder.rawValue)
                HealthReviewDescriptionView()
                    .tag(OnBoardingTab.healthReview.rawValue)
                ReviewDescriptionView()
                    .tag(OnBoardingTab.review.rawValue)
                WatchFeatureExplanationView()
                    .tag(OnBoardingTab.watchFeature.rawValue)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            if selection == .watchFeature {
                CommonButtonView(title: "はじめる") {
                    hasCompletedOnboarding = true
                }
            }
        }
        .background(Color.appBackground)
    }
}

#Preview {
    OnboardingScreenView()
}
