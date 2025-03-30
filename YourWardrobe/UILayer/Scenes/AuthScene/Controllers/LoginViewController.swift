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
    case forgotPassword
}

protocol LoginViewInputProtocol: AnyObject {
    func startLoader()
    func stopLoader()

}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var state: LoginViewState = .initial
    private var keyboardIsShown = false
    private var bottomCTValue = 0.0
    var viewOutput: LoginViewOutputProtocol!
    
    // MARK: - Views
    private lazy var bottomView = WRBottomView()
    private lazy var titleLabel = UILabel()
    private lazy var signInUsername =  WRTextField()
    private lazy var signInPassword = WRTextField()
    private lazy var signUpUsername = WRTextField()
    private lazy var signUpPassword = WRTextField()
    private lazy var signUpReEnterPassword = WRTextField()
    private lazy var forgotLabel = UILabel()
    private lazy var forgotPasswordEmail = WRTextField()
    private lazy var logoImage = UIImageView()
    private lazy var signInButton = WRButton()
    private lazy var signUpButton = WRButton()
    private lazy var forgotPasswordButton = WRButton()
    private lazy var verticalStack = UIStackView()
    private lazy var loader = UIActivityIndicatorView(style: .large)
    private lazy var loaderContainer = UIView()

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
    
    deinit {
        stopKeyboardListener()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupLayout()
        setupObservers()
        
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
            setupNavigationBar()
            
        case .signUp:
            setupBottomView()
            setupStack()
            setupSignUpUsername()
            setupSignUpPassword()
            setupSignUpReEnterPassword()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()
            setupNavigationBar()
        case .forgotPassword:
            setupBottomView()
            setupStack()
            setupTitleLabel()

        }

        
        setupLoaderView()
    }
    
    func setupNavigationBar() {
        let backImage = UIImage(resource: .backIcon)
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated: )))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = AppColors.textPrimary
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

        case .signUp:
            verticalStack.addArrangedSubview(signUpUsername)
            verticalStack.addArrangedSubview(signUpPassword)
            verticalStack.addArrangedSubview(signUpReEnterPassword)

            bottomCTValue = -227

        case .forgotPassword:
            forgotPasswordEmail.translatesAutoresizingMaskIntoConstraints = false
            forgotPasswordEmail.placeholder = "Email"
            forgotPasswordEmail.backgroundColor = AppColors.background
            forgotPasswordEmail.layer.borderColor = AppColors.accentColor.cgColor
            forgotPasswordEmail.layer.borderWidth = 0.5
            forgotPasswordEmail.heightAnchor.constraint(equalToConstant: 50).isActive = true

            forgotPasswordButton.setTitle("Continue")
            forgotPasswordButton.scheme = .orange
            forgotPasswordButton.action = { [weak self] in
                self?.onForgotPasswordTapped()
            }
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

            verticalStack.addArrangedSubview(forgotPasswordEmail)
            verticalStack.addArrangedSubview(forgotPasswordButton)

            bottomCTValue = -192
        }

        stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)

        NSLayoutConstraint.activate([
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackViewBottomCT
        ])

    }

    
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.button1Action = { [weak self] in
            self?.gmailPress()
        }
        bottomView.button2Action = { [weak self] in
            self?.facebookPress()
        }
        
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
        case .forgotPassword:
            titleLabel.text = "RETRIEVE PASSWORD"
            titleLabel.font = .Oswald.Bold.size(size: 18)
        }
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: verticalStack.topAnchor, constant: -45),
            titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40),
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
        signInButton.action = { [weak self] in
            self?.onSignInTapped()
        }
        switch state {
        case .initial:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 90),
                signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
                signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .signIn, .signUp, .forgotPassword:
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
        signUpButton.action = { [weak self] in
            self?.onSignUpTapped()
        }
        
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
        forgotLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onForgotPasswordTapped))
        forgotLabel.addGestureRecognizer(tapGesture)

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
    
    func setupLoaderView() {
        view.addSubview(loaderContainer)
        loaderContainer.translatesAutoresizingMaskIntoConstraints = false
        loaderContainer.backgroundColor = AppColors.background.withAlphaComponent(0.5)
        loaderContainer.isHidden = true
        
        NSLayoutConstraint.activate([
            loaderContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            loaderContainer.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loaderContainer.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: loaderContainer.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: loaderContainer.centerYAnchor),
        ])
    }
}

// MARK: Private Methods
private extension LoginViewController {
    func onBackPressed() {
             
         }
    
    func onSignInTapped() {
         switch state {
         case .initial:
             viewOutput.goToSignIn()
         case .signIn:
             let credentials = AuthCredentials(email: signInUsername.text ?? "",
                                               password: signInPassword.text ?? ""
             )
             viewOutput.loginStart(with: credentials)
         case .signUp:
             return
         case .forgotPassword:
             let email = forgotPasswordEmail.text ?? ""
             viewOutput.goToFogotPassword(with: email)
         }
     }
     
     func onSignUpTapped() {
         switch state {
         case .initial:
             viewOutput.goToSignUp()
         case .signIn:
             return
         case .signUp:
             let credentials = AuthCredentials(email: signUpUsername.text ?? "",
                                               password: signUpPassword.text ?? "",
                                               reenteredPassword: signUpReEnterPassword.text ?? ""
             )
             let name = signInUsername.text ?? ""
             viewOutput.registrationStart(with: credentials, name: name)
         case .forgotPassword:
             return
         }
     }
     
     func onFacebookTapped() {
         
     }
     
     func onGmailTapped() {
         
     }
     
    @objc func onForgotPasswordTapped() {
        let email = signInUsername.text ?? ""
        viewOutput.goToFogotPassword(with: email)
     }
     
     
}
// MARK: - LoginViewInput delegate
extension LoginViewController: LoginViewInputProtocol {
    func startLoader() {
        loaderContainer.isHidden = false
        loader.startAnimating()
    }
    func stopLoader() {
        loaderContainer.isHidden = true
        loader.stopAnimating()
    }
}

// MARK: - Keyboard Observers
private extension LoginViewController {
    func setupObservers() {
        startKeyboardListener()
    }
    func startKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
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
        
        if !keyboardIsShown {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant -= keyboardHeight/2
                self.view.layoutIfNeeded()
                self.keyboardIsShown = true
            }
        }
        
    }
    @objc func keyboardWillHide(_ notification: Notification) {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant = self.bottomCTValue
                self.keyboardIsShown = false
                self.view.layoutIfNeeded()
        }
    }
}

//#Preview("LoginVC") {
//    LoginViewController(viewOutput: LoginPresenter(), state: .signIn)
//}

