//
//  SceneDelegate + Ext.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

extension SceneDelegate {
    static var shared: SceneDelegate {
        return (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate)
    }
}
