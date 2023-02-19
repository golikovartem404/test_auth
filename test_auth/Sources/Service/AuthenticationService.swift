//
//  AuthenticationService.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import Foundation

class AuthenticationService {

    static let shared = AuthenticationService()
    let storageService = StorageService.shared

    private init() {}

    func signUp(
        email: String?,
        password: String?,
        confirmPassword: String?,
        completion: @escaping(Result<String, Error>) -> ()
    ) {
        guard
            let email = email,
            let password = password,
            let confirmPassword = confirmPassword
        else {
            return
        }

        guard
            email != "",
            password != "",
            confirmPassword != ""
        else {
            completion(.failure(AuthErrors.notFilled))
            return
        }

        guard ValidationService.isNormalPassword(password) else {
            completion(.failure(AuthErrors.passwordNotMatchedRequirements))
            return
        }

        guard ValidationService.isPasswordsTheSame(
            mainPassword: password,
            confirmPassword: confirmPassword
        ) else {
            completion(.failure(AuthErrors.passwordNotMatched))
            return
        }

        completion(.success(email))
        storageService.saveUser(withEmail: email, andPassword: password)
    }

    func login(
        email: String?,
        password: String?,
        completion: @escaping(Result<String, Error>) -> ()
    ) {
        guard
            let email = email,
            let password = password
        else {
            return
        }

        guard
            email != "",
            password != ""
        else {
            completion(.failure(AuthErrors.notFilled))
            return
        }

        if storageService.findUserForLogin(
            withEmail: email,
            andPassword: password
        ) == true {
            completion(.success(email))
        } else {
            completion(.failure(AuthErrors.accountNotFound))
        }
    }

    func changePasssword(
        forEmail email: String?,
        andNewPassword password: String?,
        confirmPassword: String?,
        completion: @escaping(Result<String, Error>) -> ()
    ) {
        guard
            let email = email,
            let password = password,
            let confirmPassword = confirmPassword
        else {
            completion(.failure(AuthErrors.notFilled))
            return
        }

        guard
            storageService.updateUserPassword(
                forEmail: email,
                newPassword: password
            ) == true
        else {
            completion(.failure(AuthErrors.accountNotFound))
            return
        }

        guard password == confirmPassword else {
            completion(.failure(AuthErrors.passwordNotMatched))
            return
        }
        completion(.success(Locale.paswordWasChanged.string))
    }
}
