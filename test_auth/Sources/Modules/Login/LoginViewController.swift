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
    var presenter: LoginPresenterProtocol?

    // MARK: - Outlets

    let welcomeLabel = UILabel(
        text: Locale.welcomeBackLabel.string,
        font: .avenir26()
    )
    let emailLabel = UILabel(
        text: Locale.emailLabel.string
    )
    let passwordLabel = UILabel(
        text: Locale.passwordLabel.string
    )
    let needAccountLabel = UILabel(
        text: Locale.needAccountLabel.string
    )
    let loginButton = UIButton(
        title: Locale.loginButtonTitle.string,
        titleColor: .white,
        backgroundColor: .buttonBlack()
    )
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Locale.signUpButtonTitle.string, for: .normal)
        button.setTitleColor(UIColor.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Locale.forgotPasswordButtonTitle.string, for: .normal)
        button.setTitleColor(UIColor.buttonBlack(), for: .normal)
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
    let signUpStackView = UIStackView(
        axis: .horizontal,
        spacing: 15
    )
    private lazy var blurView = BlurView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupHierarchy()
        setupLayout()
        configureTargets()
        customizeElements()
    }

    // MARK: - View Setups

    private func setupViewController() {
        view.backgroundColor = .white
        presenter = LoginPresenter()
        blurView.isHidden = true
    }

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
        view.addSubview(forgotPasswordButton)
        signUpStackView.addArrangedSubview(needAccountLabel)
        signUpStackView.addArrangedSubview(signUpButton)
        view.addSubview(signUpStackView)
        view.addSubview(blurView)
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

        forgotPasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.5)
        }

        signUpStackView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).multipliedBy(1.75)
            make.leading.equalTo(view.snp.leading).offset(40)
        }

        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func customizeElements() {
        presenter?.delegate = self
        passwordTextField.isSecureTextEntry = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func configureTargets() {
        signUpButton.addTarget(
            self,
            action: #selector(signUpButtonPressed),
            for: .touchUpInside
        )
        forgotPasswordButton.addTarget(
            self,
            action: #selector(forgotPasswordButtonPressed),
            for: .touchUpInside
        )
        loginButton.addTarget(
            self,
            action: #selector(loginButtonPressed),
            for: .touchUpInside
        )
    }

    func presentBlurView() {
        blurView.circleLoader.startAnimating()
        blurView.isHidden = false
    }
}

// MARK: - Objc methods Extension

extension LoginViewController {
    @objc private func signUpButtonPressed() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }

    @objc func forgotPasswordButtonPressed() {
        dismiss(animated: true) {
            self.delegate?.toForgotPasswordVC()
        }
    }

    @objc func loginButtonPressed() {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else {
            return
        }
        presentBlurView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.presenter?.login(withEmail: email, andPassword: password)
            self.blurView.isHidden = true
            self.blurView.circleLoader.stopAnimating()
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

// MARK: - LoginViewControllerProtocol Extension

extension LoginViewController: LoginViewControllerProtocol {
    func showAlert(withMessage message: String) {
        showFailedAlert(
            withTitle: Locale.failedAlertTitle.string,
            andMessage: message,
            completion: nil
        )
    }
}
