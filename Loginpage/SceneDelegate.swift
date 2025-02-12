//
//  SceneDelegate.swift
//  Loginpage
//
//  Created by IE13 on 02/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        applyDarkMode()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    func applyDarkMode() {
             let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "dark_mode_enabled")
             let overrideUserInterfaceStyle: UIUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
             UIApplication.shared.windows.forEach { window in
               window.overrideUserInterfaceStyle = overrideUserInterfaceStyle
             }
     }
}
