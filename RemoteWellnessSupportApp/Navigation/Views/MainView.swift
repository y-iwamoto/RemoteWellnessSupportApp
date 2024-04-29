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
            SettingScreen()
                .tabItem {
                    Label(MainTabConst.LabelName.settingsScreen, systemImage: MainTabConst.Image.settingsScreen)
                }
        }
    }
}

#Preview {
    MainView()
}
