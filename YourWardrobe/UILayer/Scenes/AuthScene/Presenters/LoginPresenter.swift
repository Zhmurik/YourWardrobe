//
//  LoginViewPresenter.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/11/25.
//

import Foundation

protocol LoginViewOutputProtocol: AnyObject {
    func loginStart(with credentials: AuthCredentials)
    func registrationStart(with credentials: AuthCredentials, name: String)
    func goToFacebookLogin()
    func goToGmailLogin()
    func goToSignIn()
    func goToSignUp()
    func goToFogotPassword(with email: String)
    func back()
}

class LoginPresenter {
    
    private var coordinator: LoginCoordinator!
    weak var viewInput: LoginViewInputProtocol?
    
    init(coordinator: LoginCoordinator? = nil, viewInput: LoginViewInputProtocol? = nil) {
        self.coordinator = coordinator
        self.viewInput = viewInput
    }
}

private extension LoginPresenter {
    func goToMainScreen() {
        coordinator?.finish()
    }
}

extension LoginPresenter: LoginViewOutputProtocol {
    func loginStart(with credentials: AuthCredentials) {
        guard credentials.isValidForSignIn else {
            viewInput?.stopLoader()
            print("❌ Inccoorrect email or password")
            return
        }

        viewInput?.startLoader()

        Task {
            do {
                let user = try await AuthService.shared.signIn(credentials: credentials)
                await MainActor.run {
                    self.viewInput?.stopLoader()
                    print("✅ Congratulations: \(user.name)")
                    self.goToMainScreen()
                }
            } catch {
                await MainActor.run {
                    self.viewInput?.stopLoader()
                    print("❌ Error: \(error.localizedDescription)")
                }
            }
        }
    }

    func registrationStart(with credentials: AuthCredentials, name: String) {
        guard credentials.isValidForSignUp else {
            print("❌ Incorrect registration data")
            viewInput?.stopLoader()
            return
        }

        viewInput?.startLoader()

        Task {
            do {
                let user = try await AuthService.shared.register(credentials: credentials, name: name)
                await MainActor.run {
                    print("✅ Successfully registered: \(user.name)")
                    viewInput?.stopLoader()
                    goToMainScreen()
                }
            } catch {
                await MainActor.run {
                    print("❌ Registration failed: \(error.localizedDescription)")
                    viewInput?.stopLoader()
                }
            }
        }
    }

    func goToFacebookLogin() {
        
    }
    func goToGmailLogin() {
        
    }
    func goToSignIn() {
        coordinator?.showSignInScene()
    }
    func goToSignUp() {
        coordinator?.showSignUpScene()
    }
    func goToFogotPassword(with email: String) {
        guard !email.isEmpty else {
            print("❌ Email can't be empty")
            return
        }

        let credentials = AuthCredentials(email: email, password: "", reenteredPassword: nil)

        Task {
            do {
                try await AuthService.shared.resetPassword(for: credentials)
                await MainActor.run {
                    print("✅ The reset link has been sent")
                }
            } catch {
                await MainActor.run {
                    print("❌ Password reset error: \(error.localizedDescription)")
                }
            }
        }
    }

    func back() {
        
    }
}

        
