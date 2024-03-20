//
//  AppDelegate.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/03/14.
//

import Foundation
import SwiftUI
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var notificationIdentifier: String? {
        get {
            UserDefaults.standard.string(forKey: "notificationIdentifier")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "notificationIdentifier")
        }
    }

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        ValueTransformer.setValueTransformer(DateArrayTransformer(), forName: NSValueTransformerName("DateArrayTransformer"))
        return true
    }

    func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        notificationIdentifier = response.notification.request.identifier
        completionHandler()
    }

    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
