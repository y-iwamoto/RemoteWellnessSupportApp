//
//  CommonLayoutView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/24.
//

import SwiftUI

struct CommonLayoutView<Content>: View where Content: View {
    let title: String
    let buttonTitle: String
    let buttonAction: () -> Void
    let content: Content
    let isFirstView: Bool

    init(title: String, buttonTitle: String, @ViewBuilder content: () -> Content, buttonAction: @escaping () -> Void, isFirstView: Bool = false) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self.content = content()
        self.isFirstView = isFirstView
    }

    var body: some View {
        VStack {
            TitleView(text: title)
            content
            Spacer()
            CommonButtonView(title: buttonTitle, action: buttonAction)
        }
        .modifier(CommonPaddingModifier(horizontal: 10, verticalTop: isFirstView ? 70 : 30, verticalBottom: 70))
    }
}
