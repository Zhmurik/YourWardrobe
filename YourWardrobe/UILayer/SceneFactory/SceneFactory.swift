//
//  SceneFactory.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/8/25.
//

import UIKit

struct SceneFactory {
    
    // MARK: Onboarding Flow
    static func makeOnboardingFlow(coordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate, navigationController: UINavigationController) {
        let onboardingCoordinator = OnboardingCoordinator(
            type: .onboarding,
            navigationController: navigationController,
            finishDelegate: finishDelegate)
        
        // add OnboardingCoordinator to childs
        coordinator.addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    
    }
    
    
    static func makeOnboardingScene(coordinator: OnboardingCoordinator) -> OnboardingViewController {
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
        
        let presenter = OnboardingViewPresenter(coordinator: coordinator)
        let viewController = OnboardingViewController(pages: pages, viewOutput: presenter)
        
        return viewController
    }
    
    //MARK: - Main Flow
    static func makeMainFlow(coordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate) -> TabBarController {
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        homeCoordinator.finishDelegate = finishDelegate
        homeCoordinator.start()
        
        let wardrobeNavigationController = UINavigationController()
        let wardrobeCoordinator = WardrobeCoordinator(type: .wardrobe, navigationController: wardrobeNavigationController)
        wardrobeNavigationController.tabBarItem = UITabBarItem(title: "Wardrobe", image: UIImage(systemName: "hanger"), tag: 1)
        wardrobeCoordinator.finishDelegate = finishDelegate
        wardrobeCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .profile, navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 2)
        profileCoordinator.finishDelegate = finishDelegate
        profileCoordinator.start()
        
        coordinator.addChildCoordinator(homeCoordinator)
        coordinator.addChildCoordinator(wardrobeCoordinator)
        coordinator.addChildCoordinator(profileCoordinator)
        
        let tabBarControllers = [homeNavigationController, wardrobeNavigationController, profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        return tabBarController
    }
}
