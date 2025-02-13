//
//  AppDelegate.swift
//  Loginpage
//
//  Created by IE13 on 02/11/23.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import IQAPIClient
@main // mnknbkn
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
      //  IQAPIClient.default.baseURL = URL(string: "https://reqres.in/api")
        IQAPIClient.default.baseURL = URL(string: "https://jsonplaceholder.typicode.com")
        return true
    }

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
