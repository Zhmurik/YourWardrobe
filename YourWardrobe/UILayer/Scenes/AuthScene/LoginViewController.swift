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
    weak var viewOutput: LoginViewOutputProtocol!
    
    // MARK: - Views
    private lazy var bottomView = WRBottomView()
    private lazy var titleLabel = UILabel()
    private lazy var signInUsername =  WRTextField()
    private lazy var signInPassword = WRTextField()
    private lazy var signUpUserName = WRTextField()
    private lazy var signUpPassword = WRTextField()
    private lazy var signUpReEnterPassword = WRTextField()
    private lazy var forgotLabel = UILabel()
    private lazy var logoImage = UIImageView()
    private lazy var signInButton = WRButton()
    private lazy var signUpButton = WRButton()

    
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
        
        bottomView.button1Action = gmailPress
        bottomView.button2Action = facebookPress
        
    }
    
    func gmailPress() {
        print("Gmail")
    }
    
    func facebookPress() {
        print("Facebook")
    }
}

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
            setupSignInPassword()
            setupSignInUsername()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()

            
        case .signUp:
            setupBottomView()

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
        view.addSubview(signInPassword)
        signInPassword.translatesAutoresizingMaskIntoConstraints = false
        signInPassword.placeholder = "Password"
        signInPassword.backgroundColor = AppColors.background
        signInPassword.layer.borderColor = AppColors.accentColor.cgColor
        signInPassword.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            signInPassword.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            signInPassword.heightAnchor.constraint(equalToConstant: 50),
            signInPassword.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signInPassword.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30)
        ])
    }
    
    func setupSignInUsername() {
        view.addSubview(signInUsername)
        signInUsername.translatesAutoresizingMaskIntoConstraints = false
        signInUsername.placeholder = "Username"
        signInUsername.backgroundColor = AppColors.background
        signInUsername.layer.borderColor = AppColors.accentColor.cgColor
        signInUsername.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            signInUsername.bottomAnchor.constraint(equalTo: signInPassword.topAnchor, constant: -20),
            signInUsername.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signInUsername.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signInUsername.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .Oswald.Bold.size(size: 36)
        titleLabel.text = "Sign In"
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: signInUsername.topAnchor, constant: -58),
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
        
        switch state {
        case .initial:

            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 90),
                signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
                signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
                
            ])
        case .signIn:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: signInPassword.bottomAnchor, constant: 40),
                signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
                signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
                
            ])
        case .signUp:
            print("Now empty")
        }
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up")
        signUpButton.scheme = .white
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
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
}

extension LoginViewController: LoginViewInputProtocol {
    
    func onSignInTapped() {
        
    }
    
    func onSignUpTapped() {
        
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

#Preview("LoginVC") {
    LoginViewController(viewOutput: LoginPresenter(), state: .initial)
}
