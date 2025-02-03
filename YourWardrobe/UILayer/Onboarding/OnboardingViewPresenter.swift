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
    
    
    
    // MARK: - Properties
    weak var coordinator: OnboardingCoordinator!
    
    init(coordinator: OnboardingCoordinator!) {
        self.coordinator = coordinator
    }
    
    func onboardingFinished() {
        coordinator.finish()
    }
    
    
}
