//
//  Strings.swift
//  test_auth
//
//  Created by User on 04.01.2023.
//

import Foundation

enum Locale: String {
    // Errors
    case notFilledError = "Please fill all fields"
    case passwordNotMatchedRequirementsError = "Password not matched requirements"
    case passwordsNotMatchedError = "Password not matched"
    case accountNotFoundError = "Account not found"
    case serverError = "Server error"

    //CoreData
    case entityName = "TestUser"
    case predicateEmail = "email == %@"
    case keyPassword = "password"
    case paswordWasChanged = "Password was changed successfully"

    //Validation
    case passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    case matchPredicateString = "SELF MATCHES %@"

    //Labels
    case changePasswordLabel = "Change Password"
    case emailLabel = "Email"
    case passwordLabel = "Password"
    case newPasswordLabel = "New Password"
    case confirmPasswordLabel = "Confirm password"
    case helloLabel = "Hello"
    case alreadyHaveAccountLabel = "Already have account?"
    case welcomeBackLabel = "Welcome back!"
    case needAccountLabel = "Need an account?"
    case signUpLabel = "Sign up with"

    //Buttons Titles
    case buttonChangePasswordTitle = "Change password"
    case signOutButtonTitle = "Sign Out"
    case signUpButtonTitle = "Sign Up"
    case loginButtonTitle = "Login"
    case forgotPasswordButtonTitle = "Forgot password"

    //UserDefaultsKeys
    case isLoggedInKey = "isLoggedIn"
    case loggedAcountEmail = "loggedAccountEmail"

    //Alerts
    case successAlertTitle = "Success"
    case failedAlertTitle = "Failed"

    var string: String {
        return rawValue
    }
}
