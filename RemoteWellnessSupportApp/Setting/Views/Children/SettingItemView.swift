//
//  SettingItemView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/29.
//

import SwiftUI

struct SettingItemView: View {
    let imageName: String
    let title: String
    let geometry: GeometryProxy
    let action: () -> Void

    var body: some View {
        HStack(spacing: 30) {
            Button(action: action) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 10, height: geometry.size.width / 10)
                Text(title)
            }
        }
        .padding(.top, 80)
        .padding(.bottom, 10)
        .padding(.horizontal, 20)
        Divider()
    }
}
