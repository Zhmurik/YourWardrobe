//
//  LoginViewPresenter.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/11/25.
//

import Foundation

protocol LoginViewOutputProtocol: AnyObject {
    func loginStart(login: String, password: String)
    func registrationStart()
    func goToFacebookLogin()
    func goToGmailLogin()
    func goToSignIn()
    func goToSignUp()
    func goToFogotPassword()
    func back()
}

class LoginPresenter {
    
    private var coordinator: AppCoordinator!
    weak var viewInput: LoginViewInputProtocol?
    
    init(coordinator: AppCoordinator? = nil, viewInput: LoginViewInputProtocol? = nil) {
        self.coordinator = coordinator
        self.viewInput = viewInput
    }
}

private extension LoginPresenter {
    func goToMainScreen() {
        coordinator?.showMainScene()
    }
}

extension LoginPresenter: LoginViewOutputProtocol {
    func loginStart(login: String, password: String) {
        viewInput?.startLoader()
        if login == "Test@gmail.com" && password == "123" {
            DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                DispatchQueue.main.async {
                    self.viewInput?.stopLoader()
                    self.goToMainScreen()
                }
            }

        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                print("wrong login or password")
                self.viewInput?.stopLoader()
            }
        }
    }
    
    func registrationStart() {
        
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
    func goToFogotPassword() {
        
    }
    func back() {
        
    }
}

        
