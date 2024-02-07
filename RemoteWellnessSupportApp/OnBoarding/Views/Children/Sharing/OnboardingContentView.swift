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
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.4, alignment: .top)
                    .padding()

                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.2, alignment: .top)

                Text(description)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.4, alignment: .top)
            }
        }
    }
}
