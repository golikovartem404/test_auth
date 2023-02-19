//
//  BlurView.swift
//  test_auth
//
//  Created by User on 06.01.2023.
//
import UIKit

class BlurView: UIView {

    let circleLoader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray
        self.layer.opacity = 0.6
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(circleLoader)
    }

    private func setupLayout() {
        circleLoader.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(200)
        }
    }
}
