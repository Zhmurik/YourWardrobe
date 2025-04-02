//
//  Controllers.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 4/1/25.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewProtocol {

    private var presenter: ProfilePresenter!
    private var user: AuthUser!
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    
    private let profileUsername = WRTextField()
    private let profileCity = WRTextField()
    private let locationGeoView = LocationGeoView()
    
    private let changePasswordButton = WRButton(scheme: .orange)
    private let saveChangesButton = WRButton(scheme: .orange)
    private let logoutButton = WRButton(scheme: .orange)
    
    // MARK: - Initializer
    init(user: AuthUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        presenter = ProfilePresenter(view: self, user: user)
        setupLayout()
        presenter.loadUserData()
    }
}

extension ProfileViewController {
    
    private func setupLayout() {
        configureScrollView()
        configureStackView()
        configureFields()
    }

    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func configureStackView() {
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -32)
        ])
    }

    private func configureFields() {
        setupTextField(profileUsername, placeholder: "Name")
        setupTextField(profileCity, placeholder: "City")
        
        locationGeoView.translatesAutoresizingMaskIntoConstraints = false
        locationGeoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        saveChangesButton.setTitle("Save")
        changePasswordButton.setTitle("Change Password")
        logoutButton.setTitle("Log out")
        
        [profileUsername, profileCity, locationGeoView, saveChangesButton, changePasswordButton, logoutButton].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }

        saveChangesButton.action = { [weak self] in
            self?.saveChanges()
        }

        changePasswordButton.action = { [weak self] in
            self?.changePasswordTapped()
        }

        logoutButton.action = { [weak self] in
            self?.logoutTapped()
        }
    }

    private func setupTextField(_ tf: UITextField, placeholder: String) {
        tf.borderStyle = .roundedRect
        tf.placeholder = placeholder
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}

extension ProfileViewController {
    
    func displayUserData(name: String, city: String?) {
        profileUsername.text = name
        profileCity.text = city
    }

    func showSuccessMessage() {
        print("Changes saved!")
    }

    func showError(_ message: String) {
        print("Error: \(message)")
    }

    private func saveChanges() {
        presenter.updateUser(
            name: profileUsername.text ?? "",
            city: profileCity.text
        )
    }

    private func changePasswordTapped() {
        print("Navigate to change password screen")
    }

    private func logoutTapped() {
        print("User logged out")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

#Preview("ProfileVC") {
    let mockUser = AuthUser(id: "123", name: "Anna", email: "anna@example.com")
    return ProfileViewController(user: mockUser)
}
#endif
