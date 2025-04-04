//
//  OnboardingCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/1/25.
//

import UIKit

// MARK: OnboardingCoordinator
class OnboardingCoordinator: Coordinator {
    
    // MARK: Properties
    private let factory = SceneFactory.self
    
    // MARK:- Methods
    override func start() {
        showOnboarding()
    }
    
    override func finish() {
        print("OnboardingCoordinator finished")
        finishDelegate?.coordinatorDidFinish(childCoordinator:  self)
    }
}

// MARK: Navigation
private extension OnboardingCoordinator {
    func showOnboarding() {
        let viewController = factory.makeOnboardingScene(coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}

