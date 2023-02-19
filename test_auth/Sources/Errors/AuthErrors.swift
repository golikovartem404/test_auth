//
//  AuthErrors.swift
//  test_auth
//
//  Created by User on 02.01.2023.

import Foundation

enum AuthErrors {
    case notFilled
    case passwordNotMatchedRequirements
    case passwordNotMatched
    case accountNotFound
    case serverError
}

extension AuthErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString(Locale.notFilledError.string, comment: "")
        case .passwordNotMatchedRequirements:
            return NSLocalizedString(Locale.passwordNotMatchedRequirementsError.string, comment: "")
        case .passwordNotMatched:
            return NSLocalizedString(Locale.passwordsNotMatchedError.string, comment: "")
        case .accountNotFound:
            return NSLocalizedString(Locale.accountNotFoundError.string, comment: "")
        case .serverError:
            return NSLocalizedString(Locale.serverError.string, comment: "")
        }
    }
}
