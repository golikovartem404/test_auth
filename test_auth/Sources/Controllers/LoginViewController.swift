//
//  LoginViewController.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties

    weak var delegate: AuthenticationNavigtionDelegate?

    // MARK: - Outlets

    let welcomeLabel = UILabel(
        text: "Welcome back!",
        font: .avenir26()
    )
    let emailLabel = UILabel(
        text: "Email"
    )
    let passwordLabel = UILabel(
        text: "Password"
    )
    let needAccountLabel = UILabel(
        text: "Need an account?"
    )
    let loginButton = UIButton(
        title: "Login",
        titleColor: .white,
        backgroundColor: .buttonBlack()
    )
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()

    let emailTextField = OneLineTextField(
        font: .avenir20()
    )
    let passwordTextField = OneLineTextField(
        font: .avenir20()
    )

    let emailStack = UIStackView(
        axis: .vertical,
        spacing: 0
    )
    let passwordStack = UIStackView(
        axis: .vertical,
        spacing: 0
    )
    let mainStackView = UIStackView(
        axis: .vertical,
        spacing: 40
    )
    let bottomStackView = UIStackView(
        axis: .horizontal,
        spacing: 15
    )

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        configureTargets()
        customizeElements()
    }

    // MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(welcomeLabel)
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailTextField)
        passwordStack.addArrangedSubview(passwordLabel)
        passwordStack.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(emailStack)
        mainStackView.addArrangedSubview(passwordStack)
        mainStackView.addArrangedSubview(loginButton)
        view.addSubview(mainStackView)
        bottomStackView.addArrangedSubview(needAccountLabel)
        bottomStackView.addArrangedSubview(signUpButton)
        view.addSubview(bottomStackView)
    }

    private func setupLayout() {
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.35)
        }

        loginButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        mainStackView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).multipliedBy(1.1)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }

        bottomStackView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).multipliedBy(1.75)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
    }

    private func customizeElements() {
        passwordTextField.isSecureTextEntry = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func configureTargets() {
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }
}

// MARK: - Actions for Buttons Extension

extension LoginViewController {
    @objc private func signUpButtonPressed() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
}

// MARK: - TextField Extension

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
