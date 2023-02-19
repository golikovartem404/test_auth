//
//  ButtonView.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

class ButtonView: UIView {

    init(label: UILabel, button: UIButton) {
        super.init(frame: .zero)
        self.addSubview(label)
        self.addSubview(button)

        label.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(70)
        }

        self.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.bottom)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
