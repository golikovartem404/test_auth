//
//  ValidationService.swift
//  test_auth
//
//  Created by User on 02.01.2023.

import Foundation

class ValidationService {

    static func isFilled(
        email: String?,
        password: String?,
        confirmPassword: String?
    ) -> Bool {
        guard
            let _ = password,
            let _ = confirmPassword,
            let _ = email
        else {
            return false
        }
        return true
    }

    static func isPasswordsTheSame(
        mainPassword: String?,
        confirmPassword: String?
    ) -> Bool {
        guard
            let mainPassword = mainPassword,
            let confirmPassword = confirmPassword
        else {
            return false
        }
        
        if mainPassword == confirmPassword {
            return true
        } else {
            return false
        }
    }

    static func isNormalPassword(_ password: String) -> Bool {
        let regEx = Locale.passwordRegEx.string
        return check(text: password, regEx: regEx)
    }

    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: Locale.matchPredicateString.string, regEx)
        return predicate.evaluate(with: text)
    }

}
