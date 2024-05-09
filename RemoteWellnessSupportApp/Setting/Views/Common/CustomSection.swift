//
//  CustomSection.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/05/09.
//

import SwiftUI

struct CustomSection<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
        .padding(10)
        .frame(maxWidth: .infinity)
    }
}
