//
//  ProfilePresenter.swift
//  test_auth
//
//  Created by User on 06.01.2023.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    var delegate: ProfileViewControllerProtocol?

    func signOut() {
        UserDefaults.standard.set(false, forKey: Locale.isLoggedInKey.string)
        UserDefaults.standard.set("", forKey: Locale.loggedAcountEmail.string)
        SceneDelegate.shared.changeViewcontroller(
            viewController: AuthenticationViewController(),
            animated: true,
            animationOptions: .transitionFlipFromRight
        )
    }
}
