//
//  ViewController.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit
import SnapKit

class AuthenticationViewController: UIViewController {

    // MARK: - Properties

    let signUpViewController = SignUpViewController()
    let loginViewController = LoginViewController()
    let forgotPasswordViewController = ForgotPasswordViewController()

    // MARK: - Outlets

    let logoImageView = UIImageView(
        image: Images.logoImage,
        contentMode: .scaleAspectFit
    )

    let signUpLabel = UILabel(
        text: Locale.signUpLabel.string,
        font: .avenir20()
    )
    let alreadyOnboardLabel = UILabel(
        text: Locale.alreadyHaveAccountLabel.string,
        font: .avenir20()
    )
    let emailButton = UIButton(
        title: Locale.emailLabel.string,
        titleColor: .white,
        backgroundColor: .buttonBlack()
    )
    let loginButton = UIButton(
        title: Locale.loginButtonTitle.string,
        titleColor: .buttonRed(),
        backgroundColor: .mainWhite(),
        isShadow: true
    )

    let mainStackView = UIStackView(
        axis: .vertical,
        spacing: 40
    )

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierachy()
        setupLayout()
        configureTargetsForButtons()
        setupDelegates()
    }

    // MARK: - Setups

    func setupDelegates() {
        loginViewController.delegate = self
        signUpViewController.delegate = self
        forgotPasswordViewController.delegate = self
    }

    func setupHierachy() {
        view.addSubview(logoImageView)
        let email = ButtonView(
            label: signUpLabel,
            button: emailButton
        )
        let alreadyOnboard = ButtonView(
            label: alreadyOnboardLabel,
            button: loginButton
        )
        mainStackView.addArrangedSubview(email)
        mainStackView.addArrangedSubview(alreadyOnboard)
        view.addSubview(mainStackView)
    }

    func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.45)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }

        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).multipliedBy(0.75)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }
    }

    private func configureTargetsForButtons() {
        emailButton.addTarget(
            self,
            action: #selector(emailButtonPressed),
            for: .touchUpInside
        )
        loginButton.addTarget(
            self,
            action: #selector(loginButtonPressed),
            for: .touchUpInside
        )
    }
}

// MARK: - Actions For Buttons Extension

extension AuthenticationViewController {

    @objc private func emailButtonPressed() {
        present(signUpViewController, animated: true)
    }

    @objc private func loginButtonPressed() {
        present(loginViewController, animated: true)
    }
}

// MARK: - AuthenticationNavigtionDelegate Extension

extension AuthenticationViewController: AuthenticationNavigtionDelegate {
    func toLoginVC() {
        present(loginViewController, animated: true)
    }

    func toSignUpVC() {
        present(signUpViewController, animated: true)
    }

    func toForgotPasswordVC() {
        present(forgotPasswordViewController, animated: true)
    }

    func goBackToLoginVC() {
        dismiss(animated: true)
    }
}

