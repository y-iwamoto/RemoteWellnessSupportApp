//
//  ItemCircleProgressView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/24.
//

import SwiftUI

struct ItemCircleProgressView: View {
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
            Text("\(itemValue)")
                .font(.title)
            Text(itemName)
        }
    }
}
