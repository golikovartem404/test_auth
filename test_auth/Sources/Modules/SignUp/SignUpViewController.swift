//
//  SignUpViewController.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Properties

    weak var delegate: AuthenticationNavigtionDelegate?
    var presenter: SignUpPresenterProtocol?

    // MARK: - Outlets

    let welcomeLabel = UILabel(
        text: Locale.helloLabel.string,
        font: .avenir26()
    )
    let emailLabel = UILabel(
        text: Locale.emailLabel.string
    )
    let emailTextField = OneLineTextField(
        font: .avenir20()
    )
    let passwordLabel = UILabel(
        text: Locale.passwordLabel.string
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
    let alreadyOnboardLabel = UILabel(
        text: Locale.alreadyHaveAccountLabel.string
    )
    let signUpButton = UIButton(
        title: Locale.signUpButtonTitle.string,
        titleColor: .white,
        backgroundColor: .buttonBlack(),
        cornerRadius: 8
    )
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Locale.loginButtonTitle.string, for: .normal)
        button.setTitleColor(UIColor.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
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
    private lazy var blurViewSecond = BlurView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupHierarchy()
        setupLayout()
        configureTargets()
        customizeElements()
        setupView()
    }

    // MARK: - View Setups

    private func setupViewController() {
        view.backgroundColor = UIColor.mainWhite()
        presenter = SignUpPresenter()
        blurView.isHidden = true
    }

    private func setupHierarchy() {
        view.addSubview(welcomeLabel)
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailTextField)
        passwordStack.addArrangedSubview(passwordLabel)
        passwordStack.addArrangedSubview(passwordTextField)
        confirmPasswordStack.addArrangedSubview(confirmPasswordLabel)
        confirmPasswordStack.addArrangedSubview(confirmPasswordTextField)
        mainStackView.addArrangedSubview(emailStack)
        mainStackView.addArrangedSubview(passwordStack)
        mainStackView.addArrangedSubview(confirmPasswordStack)
        mainStackView.addArrangedSubview(signUpButton)
        bottomStackView.addArrangedSubview(alreadyOnboardLabel)
        bottomStackView.addArrangedSubview(loginButton)
        view.addSubview(mainStackView)
        view.addSubview(bottomStackView)
        view.addSubview(blurView)
        view.addSubview(blurViewSecond)
    }

    private func setupLayout() {
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.35)
        }

        signUpButton.snp.makeConstraints { make in
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

    private func configureTargets() {
        loginButton.addTarget(
            self,
            action: #selector(loginButtonPressed),
            for: .touchUpInside
        )
        signUpButton.addTarget(
            self,
            action: #selector(signUpButtonPressed),
            for: .touchUpInside
        )
    }

    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }

    func presentBlurView() {
        blurView.circleLoader.startAnimating()
        blurView.isHidden = false
    }
}

// MARK: - Objc methods Extension

extension SignUpViewController {

    @objc private func loginButtonPressed() {
        dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }

    @objc func signUpButtonPressed() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        presentBlurView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.presenter?.signUp(
                withEmail: email,
                mainPassword: password,
                andConfirmPassword: confirmPassword
            )
            self.blurView.isHidden = true
            self.blurView.circleLoader.stopAnimating()
        }
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: - TextField Extension

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - SignUpViewControllerProtocol Extension

extension SignUpViewController: SignUpViewControllerProtocol {
    func showAlert(withMessage message: String) {
        showFailedAlert(
            withTitle: Locale.failedAlertTitle.string,
            andMessage: message,
            completion: nil
        )
    }
}
