//
//  PhysicalConditionCircleProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/09/02.
//

import SwiftUI

struct PhysicalConditionCircleProgressView: View {
    var progress: CGFloat
    var totalValue: Int
    var imageName: String
    var itemValue: Double
    var itemName: String

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 5)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                CircleProgress(progress: progress)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.green)
                    .animation(.linear, value: progress)

                Image(systemName: imageName)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .clipShape(Circle())
            }

            Text(ratingLabel(for: Int(itemValue)))
                .font(.title)
            Text(itemName)
        }
    }

    private func ratingLabel(for value: Int) -> String {
        if let rating = PhysicalConditionRating(rawValue: value) {
            rating.label
        } else {
            "未登録"
        }
    }
}
