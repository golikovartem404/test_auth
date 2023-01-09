//
//  LoginPresenter.swift
//  test_auth
//
//  Created by User on 03.01.2023.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {

    weak var delegate: LoginViewControllerProtocol?
    let authenticationService = AuthenticationService.shared

    func login(withEmail email: String, andPassword password: String) {
        authenticationService.login(
            email: email,
            password: password) { result in
                switch result {
                case .success(let email):
                    UserDefaults.standard.set(true, forKey: Locale.isLoggedInKey.string)
                    UserDefaults.standard.set(email, forKey: Locale.loggedAcountEmail.string)
                    SceneDelegate.shared.changeViewcontroller(
                        viewController: ProfileViewController(),
                        animated: true,
                        animationOptions: .transitionFlipFromRight
                    )
                case .failure(let error):
                    self.delegate?.showAlert(withMessage: error.localizedDescription)
                }
            }

    }
}
