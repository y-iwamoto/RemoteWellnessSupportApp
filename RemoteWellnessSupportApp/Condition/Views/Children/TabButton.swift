//
//  TabButton.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TabButton<T: TabTitleConvertible>: View {
    @Binding var selectedTab: T
    let title: T

    var body: some View {
        Button(
            action: {
                selectedTab = title
            },
            label: {
                Text(title.tabTitle)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.clear)
                    .foregroundColor(selectedTab.tabTitle == title.tabTitle ? .blue : .gray)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedTab.tabTitle == title.tabTitle ? .blue : .clear),
                        alignment: .bottom
                    )
            }
        )
    }
}
