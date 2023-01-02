//
//  UILabel + Ext.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .avenir20(), color: UIColor = .black) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
    }
}
