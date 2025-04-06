//
//  Controllers.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 4/1/25.
//

import UIKit


enum ProfileViewState {
    case mainProfile
    case editProfile
}

class ProfileViewController: UIViewController {

    private let contentView = UIView()
    var presenter: ProfilePresenter!
    private var user: UserProfileModel!
    private var currentState: ProfileViewState = .mainProfile
    
    // MARK: - UI Elements
    private let profileInfoTitle = UILabel()
    private let avatarImage = UIImageView()
    private let usernameLabel = UILabel()
    private let cityLabel = UILabel()
    private let genderLabel = UILabel()
    
    private let editProfileInfoTitle = UILabel()
    private let editAvatarImage = UIImageView()
    private let editUsernameTextField = WRTextField()
    private let editCityTextField = WRTextField()
    private let editGender: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Male", "Female", "I don't want to answer"])
        control.selectedSegmentIndex = 2
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    
    private let editButton = WRButton()
    private let saveButton = WRButton()
    private let logoutButton = WRButton()
    
//    private let verticalStack = UIStackView()
    
    
    // MARK: - Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        presenter = ProfilePresenter(view: self)
        presenter.loadUserData()
        setupLayout()
    }
}

extension ProfileViewController {
    
    private func setupLayout() {
        switch currentState {
        case .mainProfile:
            setupProfileInfoTitle()
            setupAvatarImage()
            setupProfileUsername()
            setupProfileCity()
            setupProfileGender()
            setupEditButton()
            setupLogoutButton()
            
        case .editProfile:
            setupEditInfoTitle()
            setupEditAvatarImage()
            setupEditUsername()
            setupEditCity()
            setupEditGender()
            setupSaveButton()
            setupLogoutButton()
        }
    }
    
    func setupProfileInfoTitle() {
        contentView.addSubview(profileInfoTitle)
        profileInfoTitle.translatesAutoresizingMaskIntoConstraints = false
        profileInfoTitle.text = "Profile"
        profileInfoTitle.font = UIFont.Oswald.Bold.size(size: 24)
        
        NSLayoutConstraint.activate([
            profileInfoTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileInfoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
    }
    func setupAvatarImage() {
        contentView.addSubview(avatarImage)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = UIImage(systemName: "person.circle")
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: profileInfoTitle.bottomAnchor, constant: 20),
            avatarImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func setupProfileUsername() {
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont.Oswald.Regular.size(size: 18)
        usernameLabel.textColor = AppColors.textPrimary
        usernameLabel.layer.borderColor = AppColors.testColor2.cgColor
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 16),
            usernameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        
        ])
    }
    
    func setupProfileCity() {
        contentView.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textColor = AppColors.textPrimary
        cityLabel.font = UIFont.Oswald.Regular.size(size: 18)
        cityLabel.layer.borderColor = AppColors.testColor2.cgColor
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    func setupProfileGender() {
        contentView.addSubview(genderLabel)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.textColor = AppColors.textPrimary
        genderLabel.font = UIFont.Oswald.Regular.size(size: 18)
        genderLabel.layer.borderColor = AppColors.testColor2.cgColor
        
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            genderLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setupEditButton() {
        contentView.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setTitle("Edit")
        editButton.scheme = .white
        editButton.action =  { [weak self] in
            self?.editTapped()
        }
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            editButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupLogoutButton() {
        contentView.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout")
        logoutButton.scheme = .orange
        logoutButton.action = { [weak self] in
            self?.logoutTapped()
        }
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupEditInfoTitle() {
        contentView.addSubview(editProfileInfoTitle)
        editProfileInfoTitle.translatesAutoresizingMaskIntoConstraints = false
        editProfileInfoTitle.text = "Edit Profile"
        editProfileInfoTitle.font = UIFont.Oswald.Bold.size(size: 24)
        
        NSLayoutConstraint.activate([
            editProfileInfoTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            editProfileInfoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
    }
    
    func setupEditAvatarImage() {
        contentView.addSubview(editAvatarImage)
        editAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        editAvatarImage.image = UIImage(systemName: "person.circle")
        
        NSLayoutConstraint.activate([
            editAvatarImage.topAnchor.constraint(equalTo: editProfileInfoTitle.bottomAnchor, constant: 20),
            editAvatarImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            editAvatarImage.widthAnchor.constraint(equalToConstant: 100),
            editAvatarImage.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func setupEditUsername() {
        contentView.addSubview(editUsernameTextField)
        editUsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        editUsernameTextField.placeholder = "Username"
        editUsernameTextField.backgroundColor = AppColors.background
        editUsernameTextField.layer.borderColor = AppColors.testColor2.cgColor
        editUsernameTextField.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            editUsernameTextField.topAnchor.constraint(equalTo: editAvatarImage.bottomAnchor, constant: 16),
            editUsernameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            editUsernameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            editUsernameTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupEditCity() {
        contentView.addSubview(editCityTextField)
        editCityTextField.translatesAutoresizingMaskIntoConstraints = false
        editCityTextField.placeholder = "City"
        editCityTextField.backgroundColor = AppColors.background
        editCityTextField.layer.borderColor = AppColors.testColor2.cgColor
        editCityTextField.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            editCityTextField.topAnchor.constraint(equalTo: editUsernameTextField.bottomAnchor, constant: 12),
            editCityTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            editCityTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            editCityTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupEditGender() {
        contentView.addSubview(editGender)
        editGender.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            editGender.topAnchor.constraint(equalTo: editCityTextField.bottomAnchor, constant: 12),
            editGender.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            editGender.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            editGender.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    
    func setupSaveButton() {
        contentView.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save")
        saveButton.scheme = .white
        saveButton.action = { [weak self] in
            self?.saveTapped()
        }
            
            NSLayoutConstraint.activate([
                saveButton.topAnchor.constraint(equalTo: editCityTextField.bottomAnchor, constant: 20),
                saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
                saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
                saveButton.widthAnchor.constraint(equalToConstant: 50),
            ])
        }
        
    // MARK: - Button Actions
        
    func editTapped() {
        currentState = .editProfile
        reloadLayout()
    }
        
    func saveTapped() {
        let selectedGender: Gender
        switch editGender.selectedSegmentIndex {
        case 0:
            selectedGender = .male
        case 1:
            selectedGender = .female
        default:
            selectedGender = .male
        }
        
        presenter.updateUser(name: editUsernameTextField.text ?? "",
                                city: editCityTextField.text ?? "",
                                gender: selectedGender)
        currentState = .mainProfile
        reloadLayout()
    }
        
    @objc func logoutTapped() {
        presenter.logout()
    }

        
    private func reloadLayout() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        setupLayout()
    }
}

extension ProfileViewController: @preconcurrency ProfileViewProtocol {

    func displayUserData(name: String, city: String?, gender: Gender) {
        usernameLabel.text = name
        cityLabel.text = city
        editUsernameTextField.text = name
        editCityTextField.text = city
        
        switch gender {
          case .male: editGender.selectedSegmentIndex = 0
          case .female: editGender.selectedSegmentIndex = 1
          case .notSpecified: editGender.selectedSegmentIndex = 2
          }
    }
    
    func showEmptyProfileEditor() {
        currentState = .editProfile
        reloadLayout()
    }


    func showSuccessMessage() {
        let alert = UIAlertController(title: "Success", message: "Profile updated", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.currentState = .mainProfile
            self?.reloadLayout()
        })
        present(alert, animated: true)
    }


    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }

    @MainActor
    func navigateToLogin() {
        let loginVC = LoginViewController(viewOutput: LoginPresenter(), state: .signIn)

        if let presenter = loginVC.viewOutput as? LoginPresenter {
            presenter.viewInput = loginVC
        }

        let navVC = UINavigationController(rootViewController: loginVC)
        navVC.modalPresentationStyle = .fullScreen

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController = navVC
            window.makeKeyAndVisible()
        }
    }


}

