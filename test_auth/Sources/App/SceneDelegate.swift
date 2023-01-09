//
//  SceneDelegate.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            window?.rootViewController = ProfileViewController()
        } else {
            window?.rootViewController = AuthenticationViewController()
        }
        window?.makeKeyAndVisible()
    }

    func changeViewcontroller(viewController: UIViewController, animated: Bool, animationOptions: UIView.AnimationOptions) {
        guard let window = window else { return }
        window.rootViewController = viewController
        let options: UIView.AnimationOptions = [animationOptions]
        UIView.transition(
            with: window,
            duration: 0.5,
            options: options,
            animations: nil,
            completion: nil
        )
    }
}

