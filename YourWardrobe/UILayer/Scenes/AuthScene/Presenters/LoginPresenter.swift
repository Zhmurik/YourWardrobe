//
//  LoginViewPresenter.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/11/25.
//

import Foundation

protocol LoginViewOutputProtocol: AnyObject {
    func loginStart()
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
    weak var viewIput: LoginViewInputProtocol?
    
    init(coordinator: AppCoordinator? = nil, viewInput: LoginViewInputProtocol? = nil) {
        self.coordinator = coordinator
        self.viewIput = viewInput
    }
}

extension LoginPresenter: LoginViewOutputProtocol {
    func loginStart() {
        
    }
    func registrationStart() {
        
    }
    func goToFacebookLogin() {
        
    }
    func goToGmailLogin() {
        
    }
    func goToSignIn() {
        
    }
    func goToSignUp() {
        
    }
    func goToFogotPassword() {
        
    }
    func back() {
        
    }
}

        
