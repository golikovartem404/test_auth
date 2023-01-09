//
//  SignUpPresenter.swift
//  test_auth
//
//  Created by User on 03.01.2023.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {

    weak var delegate: SignUpViewControllerProtocol?
    let authenticationService = AuthenticationService.shared

    func signUp(
        withEmail email: String?,
        mainPassword password: String?,
        andConfirmPassword confirmPassword: String?
    ) {
        authenticationService.signUp(
            email: email,
            password: password,
            confirmPassword: confirmPassword
        ) { result in
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
