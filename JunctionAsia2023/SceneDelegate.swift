//
//  SceneDelegate.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/18.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let viewController = UserDataInfoViewController()

        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation

        self.window = window
        window.makeKeyAndVisible()
    }
}

