//
//  ResetPasswordViewController.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    // MARK: - Properties
    
    weak var delegate: AuthenticationNavigtionDelegate?
    var presenter: ForgotPasswordPresenterProtocol?

    // MARK: - Outlets

    let changePasswordLabel = UILabel(
        text: Locale.changePasswordLabel.string,
        font: .avenir26()
    )
    let emailLabel = UILabel(
        text: Locale.emailLabel.string
    )
    let emailTextField = OneLineTextField(
        font: .avenir20()
    )
    let passwordLabel = UILabel(
        text: Locale.newPasswordLabel.string
    )
    let passwordTextField = OneLineTextField(
        font: .avenir20()
    )
    let confirmPasswordLabel = UILabel(
        text: Locale.confirmPasswordLabel.string
    )
    let confirmPasswordTextField = OneLineTextField(
        font: .avenir20()
    )
    let changePasswordButton = UIButton(
        title: Locale.buttonChangePasswordTitle.string,
        titleColor: .white,
        backgroundColor: .buttonBlack(),
        cornerRadius: 8
    )
    let emailStack = UIStackView(
        axis: .vertical,
        spacing: 0
    )
    let passwordStack = UIStackView(
        axis: .vertical,
        spacing: 0
    )
    let confirmPasswordStack = UIStackView(
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
    private lazy var blurView = BlurView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupHierarchy()
        setupLayout()
        customizeElements()
        setupView()
        setTargetsForButtons()
    }

    // MARK: - View Setups

    private func setupViewController() {
        view.backgroundColor = UIColor.mainWhite()
        presenter = ForgotPasswordPresenter()
        blurView.isHidden = true
    }

    private func setupHierarchy() {
        view.addSubview(changePasswordLabel)
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailTextField)
        passwordStack.addArrangedSubview(passwordLabel)
        passwordStack.addArrangedSubview(passwordTextField)
        confirmPasswordStack.addArrangedSubview(confirmPasswordLabel)
        confirmPasswordStack.addArrangedSubview(confirmPasswordTextField)
        mainStackView.addArrangedSubview(emailStack)
        mainStackView.addArrangedSubview(passwordStack)
        mainStackView.addArrangedSubview(confirmPasswordStack)
        mainStackView.addArrangedSubview(changePasswordButton)
        view.addSubview(mainStackView)
        view.addSubview(bottomStackView)
        view.addSubview(blurView)
    }

    private func setupLayout() {
        changePasswordLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.35)
        }

        changePasswordButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        mainStackView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }

        bottomStackView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).multipliedBy(1.6)
            make.leading.equalTo(view.snp.leading).offset(40)
        }

        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func customizeElements() {
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        presenter?.delegate = self
    }

    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }

    private func setTargetsForButtons() {
        changePasswordButton.addTarget(
            self,
            action: #selector(changePasswordButtonPressed),
            for: .touchUpInside
        )
    }

    func presentBlurView() {
        blurView.circleLoader.startAnimating()
        blurView.isHidden = false
    }
}

// MARK: - Objc methods Extension

extension ForgotPasswordViewController {
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    @objc func changePasswordButtonPressed() {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text,
            password == confirmPassword
        else {
            return
        }
        presentBlurView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.presenter?.changePassword(
                withEmail: email,
                newPassword: password,
                andConfirmPassword: confirmPassword
            )
            self.blurView.isHidden = true
            self.blurView.circleLoader.stopAnimating()
        }
    }
}

// MARK: - TextField Extension

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - ForgotPasswordViewControllerProtocol Extension

extension ForgotPasswordViewController: ForgotPasswordViewControllerProtocol {

    func showSuccessAlert(withMessage message: String) {
        showSuccessAlert(withTitle: Locale.successAlertTitle.string, andMessage: message) { _ in
            self.delegate?.goBackToLoginVC()
        }
    }

    func showFailedAlert(withMessage message: String) {
        showFailedAlert(withTitle: Locale.failedAlertTitle.string, andMessage: message, completion: nil)
    }
}
