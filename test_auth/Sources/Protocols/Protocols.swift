//
//  AuthNavigationDelegate.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import Foundation

protocol AuthenticationNavigtionDelegate: AnyObject {
    func toLoginVC()
    func toSignUpVC()
    func toForgotPasswordVC()
    func goBackToLoginVC()
}

protocol LoginViewControllerProtocol: AnyObject {
    func showAlert(withMessage message: String)
}

protocol LoginPresenterProtocol {
    var delegate: LoginViewControllerProtocol? { get set }
    func login(withEmail email: String, andPassword password: String)
}

protocol SignUpViewControllerProtocol: AnyObject {
    func showAlert(withMessage message: String)
}

protocol SignUpPresenterProtocol {
    var delegate: SignUpViewControllerProtocol? { get set }
    func signUp(withEmail email: String?, mainPassword password: String?, andConfirmPassword confirmPassword: String?)
}

protocol ForgotPasswordViewControllerProtocol: AnyObject {
    func showSuccessAlert(withMessage message: String)
    func showFailedAlert(withMessage message: String)
}

protocol ForgotPasswordPresenterProtocol {
    var delegate: ForgotPasswordViewControllerProtocol? { get set }
    func changePassword(withEmail email: String, newPassword password: String, andConfirmPassword confirmPassword: String)
}

protocol ProfilePresenterProtocol {
    var delegate: ProfileViewControllerProtocol? { get set }
    func signOut()
}

protocol ProfileViewControllerProtocol {

}
