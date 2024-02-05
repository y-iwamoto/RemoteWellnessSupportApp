//
//  TabButton.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TabButton: View {
    let title: String
    @Binding var selectedTab: String

    var body: some View {
        Button(
            action: {
                selectedTab = title
            },
            label: {
                Text(title)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.clear)
                    .foregroundColor(selectedTab == title ? .blue : .gray)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedTab == title ? .blue : .clear),
                        alignment: .bottom
                    )
            }
        )
    }
}

#Preview {
    TabButton(title: "Home", selectedTab: .constant("Home"))
}
