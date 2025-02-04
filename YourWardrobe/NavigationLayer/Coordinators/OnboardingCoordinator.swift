//
//  OnboardingCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/1/25.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    override func start() {
        showOnboarding()
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

private extension OnboardingCoordinator {
    func showOnboarding() {
        
        var pages = [OnboardingPartViewController]()
        let firstVC = OnboardingPartViewController()
        firstVC.imageToShow = UIImage(resource: .wardrobeIcon)
        firstVC.titleText = "Your Closet is online"
        firstVC.descriptionText = "Always have access to your wardrobe"
        firstVC.buttonText = "Next"
        
        let secondVC = OnboardingPartViewController()
        secondVC.imageToShow = UIImage(resource: .clothes)
        secondVC.titleText = "Visual representation"
        secondVC.descriptionText = "You know exactly what you have"
        secondVC.buttonText = "Next"
        
        let thirdVC = OnboardingPartViewController()
        thirdVC.imageToShow = UIImage(resource: .mirror)
        thirdVC.titleText = "Your image"
        thirdVC.descriptionText = "Create and maintain versatile wardrobe"
        thirdVC.buttonText = "Next"
        
        let fourthVC = OnboardingPartViewController()
        fourthVC.imageToShow = UIImage(resource: .money)
        fourthVC.titleText = "Safety first"
        fourthVC.descriptionText = "Stick to a budget and invest in pieces that truly complement your wardrobe and personal style"
        fourthVC.buttonText = "Let`s start"
        
        pages.append(firstVC)
        pages.append(secondVC)
        pages.append(thirdVC)
        pages.append(fourthVC)
        
        let presenter = OnboardingViewPresenter(coordinator: self)
        let viewController = OnboardingViewController(pages: pages, viewOutput: presenter)
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}

