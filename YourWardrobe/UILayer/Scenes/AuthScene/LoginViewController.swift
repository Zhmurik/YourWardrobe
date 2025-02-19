//
//  LoginViewController.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/9/25.
//

import UIKit

enum LoginViewState {
    case initial
    case signIn
    case signUp
}

protocol LoginViewInputProtocol: AnyObject {
    func onSignInTapped()
    func onSignUpTapped()
    func onFacebookTapped()
    func onGmailTapped()
    func onForgotPasswordTapped()
    func onBackPressed()
}


class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var state: LoginViewState = .initial
    var viewOutput: LoginViewOutputProtocol!
    private var isKeyboardShown = false
    private var bottomCTValue = 0.0
    
    // MARK: - Views
    private lazy var bottomView = WRBottomView()
    private lazy var titleLabel = UILabel()
    private lazy var signInUsername =  WRTextField()
    private lazy var signInPassword = WRTextField()
    private lazy var signUpUsername = WRTextField()
    private lazy var signUpPassword = WRTextField()
    private lazy var signUpReEnterPassword = WRTextField()
    private lazy var forgotLabel = UILabel()
    private lazy var logoImage = UIImageView()
    private lazy var signInButton = WRButton()
    private lazy var signUpButton = WRButton()
    private lazy var verticalStack = UIStackView()

    // MARK: - Constraints
    private var stackViewBottomCT = NSLayoutConstraint()
    
    
    // MARK: - initializers
    init(viewOutput: LoginViewOutputProtocol, state: LoginViewState) {
        self.viewOutput = viewOutput
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupLayout()
        setupObservers()
        
        bottomView.button1Action = gmailPress
        bottomView.button2Action = facebookPress
        
    }
    
    deinit {
        stopKeyboardListener()
    }
    
    func gmailPress() {
        print("Gmail")
    }
    
    func facebookPress() {
        print("Facebook")
    }
}

// MARK: Layout
private extension LoginViewController {
    func setupLayout() {
        switch state {
        case .initial:
            setupBottomView()
            setupLogoImage()
            setupSignInButton()
            setupSignUpButton()

        case .signIn:
            setupBottomView()
            setupStack()
            setupSignInPassword()
            setupSignInUsername()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()

            
        case .signUp:
            setupBottomView()
            setupStack()
            setupSignUpUsername()
            setupSignUpPassword()
            setupSignUpReEnterPassword()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()
        }

    }
    
    func setupStack() {
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        
        switch state {
        case .initial:
            return
        case .signIn:
            verticalStack.addArrangedSubview(signInUsername)
            verticalStack.addArrangedSubview(signInPassword)
            bottomCTValue = -262
            stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)
            
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackViewBottomCT
            ])
        case .signUp:
            verticalStack.addArrangedSubview(signUpUsername)
            verticalStack.addArrangedSubview(signUpPassword)
            verticalStack.addArrangedSubview(signUpReEnterPassword)
            bottomCTValue = -227
            stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)
            
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackViewBottomCT
            ])
        }

    }
    
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    func setupSignInPassword() {
        signInPassword.translatesAutoresizingMaskIntoConstraints = false
        signInPassword.placeholder = "Password"
        signInPassword.backgroundColor = AppColors.background
        signInPassword.layer.borderColor = AppColors.accentColor.cgColor
        signInPassword.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            signInPassword.heightAnchor.constraint(equalToConstant: 50),
            signInPassword.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signInPassword.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30)
        ])
    }
    
    func setupSignInUsername() {
        signInUsername.translatesAutoresizingMaskIntoConstraints = false
        signInUsername.placeholder = "Username"
        signInUsername.backgroundColor = AppColors.background
        signInUsername.layer.borderColor = AppColors.accentColor.cgColor
        signInUsername.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            signInUsername.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signInUsername.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signInUsername.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .Oswald.Bold.size(size: 36)
        
        switch state {
        case .signIn:
            titleLabel.text = "Sign In"
        case .signUp:
            titleLabel.text = "Sign Up"
        case .initial:
            return
        }
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: verticalStack.topAnchor, constant: -58),
            titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupLogoImage() {
        view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(resource: .logo)

        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 140),
            logoImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 70),
            logoImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80),
            logoImage.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setupSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In")
        signInButton.scheme = .orange
        signInButton.action = onSignInTapped
        switch state {
        case .initial:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 90),
                signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
                signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .signIn, .signUp:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 40),
                signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
                signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up")
        signUpButton.scheme = .orange
        signUpButton.action = onSignUpTapped
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signUpButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupForgotLabel() {
        view.addSubview(forgotLabel)
        
        forgotLabel.translatesAutoresizingMaskIntoConstraints = false
        forgotLabel.textColor = AppColors.textPrimary
        forgotLabel.font = .Oswald.ExtraLight.size(size: 14)
        forgotLabel.text = "Forgot Password?"
        
        NSLayoutConstraint.activate([
            forgotLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            forgotLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),

            
            
        ])
    }
    
    func setupSignUpPassword() {
        signUpPassword.translatesAutoresizingMaskIntoConstraints = false
        signUpPassword.placeholder = "Enter Password"
        signUpPassword.backgroundColor = AppColors.background
        signUpPassword.layer.borderColor = AppColors.accentColor.cgColor
        signUpPassword.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            signUpPassword.heightAnchor.constraint(equalToConstant: 50),
            signUpPassword.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signUpPassword.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30)
        ])
    }
    
    func setupSignUpUsername() {
        signUpUsername.translatesAutoresizingMaskIntoConstraints = false
        signUpUsername.placeholder = "Enter Username"
        signUpUsername.backgroundColor = AppColors.background
        signUpUsername.layer.borderColor = AppColors.accentColor.cgColor
        signUpUsername.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            signUpUsername.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signUpUsername.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signUpUsername.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupSignUpReEnterPassword() {
        signUpReEnterPassword.translatesAutoresizingMaskIntoConstraints = false
        signUpReEnterPassword.placeholder = "Re-Enter Password"
        signUpReEnterPassword.backgroundColor = AppColors.background
        signUpReEnterPassword.layer.borderColor = AppColors.accentColor.cgColor
        signUpReEnterPassword.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            signUpReEnterPassword.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signUpReEnterPassword.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signUpReEnterPassword.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

// MARK: - LoginViewInput delegate
extension LoginViewController: LoginViewInputProtocol {
    
    func onSignInTapped() {
        switch state {
        case .initial:
            viewOutput.goToSignIn()
        case .signIn:
            return
        case .signUp:
            return
        }
    }
    
    func onSignUpTapped() {
        switch state {
        case .initial:
            viewOutput.goToSignUp()
        case .signIn:
            return
        case .signUp:
            return
        }
    }
    
    func onFacebookTapped() {
        
    }
    
    func onGmailTapped() {
        
    }
    
    func onForgotPasswordTapped() {
        
    }
    
    func onBackPressed() {
        
    }
}

// MARK: - Observers
private extension LoginViewController {
    func setupObservers() {
        startKeyboardListener()
    }
    func startKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    func stopKeyboardListener() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if !isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant -= keyboardHeight/4
                self.view.layoutIfNeeded()
                self.isKeyboardShown = true
            }
        }
        
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant = self.bottomCTValue
                self.view.layoutIfNeeded()
                self.isKeyboardShown = true
            }
        }
    }
}

//#Preview("LoginVC") {
//    LoginViewController(viewOutput: LoginPresenter(), state: .initial)
//}
