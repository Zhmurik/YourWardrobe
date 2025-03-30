//
//  LoginCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/20/25.
//

import UIKit

// MARK: LoginCoordinator
class LoginCoordinator: Coordinator {
    
    // MARK: Properties
    private let factory = SceneFactory.self
    
    // MARK:- Methods
    override func start() {
        showAuthScene()
    }
    
    override func finish() {
        print("LoginCoordinator finished")
        finishDelegate?.coordinatorDidFinish(childCoordinator:  self)
    }
}

// MARK: Navigation
extension LoginCoordinator {
    func showAuthScene() {
        guard let navigationController = navigationController else { return }
        let vc = factory.makeAuthScene(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    func showSignInScene() {
        guard let navigationController = navigationController else { return }
        let vc = factory.makeSignInScene(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSignUpScene() {
        guard let navigationController = navigationController else { return }
        let vc = factory.makeSignUpScene(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showForgotPasswordScene() {
        guard let navigationController = navigationController else { return }
        let vc = factory.makeForgotPasswordScene(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

