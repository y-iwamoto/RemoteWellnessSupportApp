//
//  RemoteWellnessSupportApp.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/01/24.
//

import SwiftData
import SwiftUI

@main
struct RemoteWellnessSupportApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        ValueTransformer.setValueTransformer(DateArrayTransformer(), forName: NSValueTransformerName("DateArrayTransformer"))
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
