//
//  OnboardingViewPresenter.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/3/25.
//

import UIKit

protocol OnboardingViewOutput: AnyObject {
    func onboardingFinished()
}

class OnboardingViewPresenter: OnboardingViewOutput {
    
    private let userStorage = UserStorage.shared
    
    // MARK: - Properties
    weak var coordinator: OnboardingCoordinator!
    
    init(coordinator: OnboardingCoordinator!) {
        self.coordinator = coordinator
    }
    
    func onboardingFinished() {
        guard let coordinatorValue = coordinator else {return}
        userStorage.passedOnboarding = true
        coordinatorValue.finish()
    }
    
    
}
