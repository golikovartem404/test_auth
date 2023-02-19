//
//  ForgotPasswordPresenter.swift
//  test_auth
//
//  Created by User on 03.01.2023.
//

import Foundation

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {

    weak var delegate: ForgotPasswordViewControllerProtocol?
    let authenticationService = AuthenticationService.shared

    func changePassword(
        withEmail email: String,
        newPassword password: String,
        andConfirmPassword confirmPassword: String
    ) {
        authenticationService.changePasssword(
            forEmail: email,
            andNewPassword: password,
            confirmPassword: confirmPassword
        ) { result in
            switch result {
            case .success(let message):
                self.delegate?.showSuccessAlert(withMessage: message)
            case .failure(let error):
                self.delegate?.showFailedAlert(withMessage: error.localizedDescription)
            }
        }
    }
}
