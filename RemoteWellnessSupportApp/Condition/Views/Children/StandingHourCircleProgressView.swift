//
//  StandingHourCircleProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/09/22.
//

import SwiftUI

struct StandingHourCircleProgressView: View {
    var progress: CGFloat
    var totalValue: Int
    var imageName: String
    var itemValue: Int
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
            Text(itemValue == 1 ? "立った時間あり" : "座ったまま")
                .font(.headline)
                .padding(.top, 15)
            Text(itemName)
        }
    }
}
