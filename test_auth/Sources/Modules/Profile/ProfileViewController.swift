//
//  ProfileViewController.swift
//  test_auth
//
//  Created by User on 02.01.2023.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {

    // MARK: - Properties

    var email = UserDefaults.standard.string(forKey: "loggedAccountEmail")
    var presenter: ProfilePresenterProtocol?

    // MARK: - Outlets

    private lazy var descriptionLabel = UILabel(text: "Logged account email")

    private lazy var emailLabel: UILabel = {
        let label = UILabel(text: email ?? "")
        label.textAlignment = .center
        return label
    }()

    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Locale.signOutButtonTitle.string, for: .normal)
        button.setTitleColor(UIColor.buttonRed(), for: .normal)
        button.titleLabel?.font = UIFont.avenir20()
        button.addTarget(
            self,
            action: #selector(signOut),
            for: .touchUpInside
        )
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - View Setups

    private func setupViewController() {
        view.backgroundColor = UIColor.mainWhite()
        presenter = ProfilePresenter()
    }

    private func setupHierarchy() {
        view.addSubview(descriptionLabel)
        view.addSubview(emailLabel)
        view.addSubview(signOutButton)
    }

    private func setupLayout() {
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).multipliedBy(0.9)
        }

        emailLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalTo(view.snp.height).multipliedBy(0.05)
        }

        signOutButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).multipliedBy(1.7)
        }
    }
}

// MARK: - Objc methods Extension

extension ProfileViewController {
    @objc func signOut() {
        presenter?.signOut()
    }
}
