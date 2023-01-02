//
//  UIImageView + Ext.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

extension UIImageView {

    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }

    func setupColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }

}
