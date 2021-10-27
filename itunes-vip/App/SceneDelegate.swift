//
//  SceneDelegate.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo
               session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        setupRootViewController(scene: scene)
//        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func setupRootViewController(scene: UIScene) {
        if let windowScene: UIWindowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            let homeScreen = HomeScreenBuilder.viewController()
            let homeNavigationController = CustomNavigationController.init(rootViewController: homeScreen)
            homeNavigationController.view.backgroundColor = .black
            self.window?.rootViewController = homeNavigationController
            self.window?.makeKeyAndVisible()
        }
    }
}
