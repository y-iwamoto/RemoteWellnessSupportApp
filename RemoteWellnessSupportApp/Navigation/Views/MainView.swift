//
//  MainView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Text("Condition")
                .tabItem {
                    Label("Condition", systemImage: "heart.text.square")
                }

            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
