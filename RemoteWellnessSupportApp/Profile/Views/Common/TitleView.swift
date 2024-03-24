//
//  TitleView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import SwiftUI

struct TitleView: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.title3)
            .padding(.bottom, 50)
    }
}
