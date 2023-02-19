//
//  OneLineTextField.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

class OneLineTextField: UITextField {
    convenience init(font: UIFont? = .avenir20()) {
        self.init()
        self.font = font
        self.borderStyle = .none
        self.textColor = .black
        self.returnKeyType = .done

        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0, y: 0, width: 3, height: 1)
        bottomView.backgroundColor = .textFieldBorder()
        self.addSubview(bottomView)

        bottomView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(1)
        }
    }
}
