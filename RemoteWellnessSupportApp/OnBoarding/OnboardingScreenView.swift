//
//  OnboardingScreenView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/31.
//

import SwiftUI

struct OnboardingScreenView: View {
    var body: some View {
        TabView {
            IntroductionView()
                .tag(OnBoardingTab.introduction)
            ReminderExplanationView()
                .tag(OnBoardingTab.reminder)
            ReviewDescriptionView()
                .tag(OnBoardingTab.review)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .background(Color.appBackground)
    }
}

#Preview {
    OnboardingScreenView()
}
