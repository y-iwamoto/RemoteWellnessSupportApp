//
//  CommonPaddingModifier.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import SwiftUI

struct CommonPaddingModifier: ViewModifier {
    var horizontal: CGFloat = 10
    var verticalTop: CGFloat = 30
    var verticalBottom: CGFloat = 70

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, horizontal)
            .padding(.top, verticalTop)
            .padding(.bottom, verticalBottom)
    }
}
