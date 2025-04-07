//
//  Controllers.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 4/1/25.
//

import UIKit

enum ProfileViewState {
    case view
    case edit
}

class ProfileViewController: UIViewController {

    var presenter: ProfilePresenter!
    private var user: UserProfileModel!
    private var currentState: ProfileViewState = .view

    // UI Components
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private let titleLabel = UILabel()
    private let personalInfoHeader = UIStackView()
    private let personalInfoLabel = UILabel()
    private let editButton = UIButton(type: .system)

    private let nameLabel = UILabel()
    private let cityLabel = UILabel()
    private let genderLabel = UILabel()

    private let nameField = WRTextField()
    private let cityField = WRTextField()
    private let genderField = WRTextField()

    private let settingsLabel = UILabel()
    private let notificationRow = UIStackView()
    private let notificationsLabel = UILabel()
    private let notificationsSwitch = UISwitch()

    private let languageRow = UIStackView()
    private let languageLabel = UILabel()
    private let languageButton = UIButton(type: .system)

    private let logoutButton = UIButton(type: .system)

    private let genderPicker = UIPickerView()
    private let genderOptions = ["Male", "Female", "Specify"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        presenter = ProfilePresenter(view: self)
        presenter.loadUserData()
        setupUI()
    }

    private func setupUI() {
        setupScrollView()
        setupStackView()
        setupHeader()
        setupEditablePersonalInfo()
        setupSettingsSection()
        setupLogoutButton()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }

    private func setupHeader() {
        titleLabel.text = "Account Settings"
        titleLabel.font = UIFont.Oswald.Bold.size(size: 28)
        titleLabel.textColor = AppColors.textPrimary

        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)

        let headerRow = UIStackView(arrangedSubviews: [titleLabel, editButton])
        headerRow.axis = .horizontal
        headerRow.distribution = .equalSpacing
        stackView.addArrangedSubview(headerRow)
    }

    private func setupEditablePersonalInfo() {
        personalInfoLabel.text = "Personal Information"
        personalInfoLabel.font = UIFont.Oswald.SemiBold.size(size: 18)
        personalInfoLabel.textColor = AppColors.textPrimary

        personalInfoHeader.axis = .horizontal
        personalInfoHeader.distribution = .equalSpacing
        personalInfoHeader.addArrangedSubview(personalInfoLabel)
        stackView.addArrangedSubview(personalInfoHeader)

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(genderLabel)

        nameField.placeholder = "Enter name"
        nameField.backgroundColor = .clear
        nameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameField.layer.borderColor = AppColors.accentColor.cgColor
        nameField.layer.borderWidth = 0.5

        cityField.placeholder = "Enter city"
        cityField.backgroundColor = .clear
        cityField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cityField.layer.borderColor = AppColors.accentColor.cgColor
        cityField.layer.borderWidth = 0.5

        genderField.placeholder = "Select gender"
        genderField.inputView = genderPicker
        genderField.backgroundColor = .clear
        genderField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        genderField.layer.borderColor = AppColors.accentColor.cgColor
        genderField.layer.borderWidth = 0.5

        genderPicker.delegate = self
        genderPicker.dataSource = self

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissGenderPicker))
        toolbar.setItems([doneButton], animated: true)
        genderField.inputAccessoryView = toolbar
    }

    private func setupSettingsSection() {
        settingsLabel.text = "Settings"
        settingsLabel.font = UIFont.Oswald.SemiBold.size(size: 18)
        settingsLabel.textColor = AppColors.textPrimary
        stackView.addArrangedSubview(settingsLabel)

        notificationsLabel.text = "Notifications"
        notificationRow.axis = .horizontal
        notificationRow.distribution = .equalSpacing
        notificationRow.addArrangedSubview(notificationsLabel)
        notificationRow.addArrangedSubview(notificationsSwitch)
        stackView.addArrangedSubview(notificationRow)

        languageLabel.text = "Language"
        languageButton.setTitle("English ⌄", for: .normal)
        languageButton.addTarget(self, action: #selector(selectLanguage), for: .touchUpInside)
        languageRow.axis = .horizontal
        languageRow.distribution = .equalSpacing
        languageRow.addArrangedSubview(languageLabel)
        languageRow.addArrangedSubview(languageButton)
        stackView.addArrangedSubview(languageRow)
    }

    private func setupLogoutButton() {
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = AppColors.accentColor
        logoutButton.layer.cornerRadius = 10
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        stackView.addArrangedSubview(logoutButton)
    }

    @objc private func editTapped() {
        guard currentState == .view else { return }
        currentState = .edit

        nameLabel.removeFromSuperview()
        cityLabel.removeFromSuperview()
        genderLabel.removeFromSuperview()

        nameField.text = user?.name
        cityField.text = user?.city
        genderField.text = genderOptions[genderPicker.selectedRow(inComponent: 0)] ?? "Specify"

        stackView.insertArrangedSubview(nameField, at: 2)
        stackView.insertArrangedSubview(cityField, at: 3)
        stackView.insertArrangedSubview(genderField, at: 4)

        editButton.setTitle("Save", for: .normal)
        editButton.setImage(nil, for: .normal)
        editButton.removeTarget(self, action: #selector(editTapped), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    @objc private func saveTapped() {
        let name = nameField.text ?? ""
        let city = cityField.text
        let gender = selectedGenderFromPicker()

        presenter.updateUser(name: name, city: city, gender: gender)

        nameField.removeFromSuperview()
        cityField.removeFromSuperview()
        genderField.removeFromSuperview()

        nameLabel.text = "Name: \(name)"
        cityLabel.text = "City: \(city ?? "")"
        genderLabel.text = "Gender: \(gender.rawValue.capitalized)"

        stackView.insertArrangedSubview(nameLabel, at: 2)
        stackView.insertArrangedSubview(cityLabel, at: 3)
        stackView.insertArrangedSubview(genderLabel, at: 4)

        editButton.setTitle(nil, for: .normal)
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.removeTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)

        currentState = .view
    }

    @objc private func dismissGenderPicker() {
        genderField.resignFirstResponder()
    }

    @objc private func logoutTapped() {
        presenter.logout()
    }

    @objc private func selectLanguage() {
        // implement language selection
    }

    private func selectedGenderFromPicker() -> Gender {
        switch genderPicker.selectedRow(inComponent: 0) {
        case 0: return .male
        case 1: return .female
        default: return .notSpecified
        }
    }
}

// MARK: - Picker

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderOptions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genderOptions[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genderOptions[row]
    }
}

// MARK: - View Protocol

extension ProfileViewController: @preconcurrency ProfileViewProtocol {
    func showEmptyProfileEditor() {
        currentState = .edit
        editTapped()
    }

    func displayUserData(name: String, city: String?, gender: Gender) {
        user = UserProfileModel(name: name, gender: gender, city: city)

        nameLabel.text = "Name: \(name)"
        cityLabel.text = "City: \(city ?? "")"
        genderLabel.text = "Gender: \(gender.rawValue.capitalized)"
    }

    func showSuccessMessage() {
        let alert = UIAlertController(title: "Success", message: "Profile updated", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
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
