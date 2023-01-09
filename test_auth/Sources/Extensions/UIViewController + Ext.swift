//
//  UIViewController + Ext.swift
//  test_auth
//
//  Created by User on 03.01.2023.
//

import UIKit

extension UIViewController {
    func showSuccessAlert(withTitle title: String, andMessage message: String, completion: ((UIAlertAction) -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: completion)
        alert.addAction(actionOK)
        present(alert, animated: true)
    }

    func showFailedAlert(withTitle title: String, andMessage message: String, completion: ((UIAlertAction) -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Try again", style: .default, handler: completion)
        alert.addAction(actionOK)
        present(alert, animated: true)
    }
}
