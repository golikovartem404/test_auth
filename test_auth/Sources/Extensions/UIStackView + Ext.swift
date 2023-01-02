//
//  UIStackView + Ext.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init()
        self.axis = axis
        self.spacing = spacing
    }
}
