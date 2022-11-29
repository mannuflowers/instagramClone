//
//  SceneDelegate.swift
//  InstagramFirebase
//
//  Created by Brian Voong on 5/2/20.
//  Copyright © 2020 Lets Build That App. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = MainTabBarController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
