//
//  OnboardingContentView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/30.
//

import SwiftUI

struct OnboardingContentView: View {
    var imageName: String
    var title: String
    var description: String

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.45, alignment: .top)
                    .padding(2)

                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.15, alignment: .top)

                Text(description)
                    .font(.body)
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.4, alignment: .top)
            }
        }
    }
}
