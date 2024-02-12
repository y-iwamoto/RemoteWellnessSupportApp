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
            ConditionScreen()
                .tabItem {
                    Label(MainTabConst.LabelName.conditionScreen, systemImage: MainTabConst.Image.conditionScreen)
                }
            // TODO: 現状はダミーで作成、設定画面作成時に対応
            Text("Settings")
                .tabItem {
                    Label(MainTabConst.LabelName.settingsScreen, systemImage: MainTabConst.Image.settingsScreen)
                }
        }
    }
}

#Preview {
    MainView()
}
