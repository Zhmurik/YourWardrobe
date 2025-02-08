//
//  AppCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/1/25.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let userStorage = UserStorage.shared
    
    override func start() {
        if userStorage.passedOnboarding {
            showMainFlow()
        } else {
            showOnboardingFlow()
        }
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

// MARK: - Navigation methods
private extension AppCoordinator {
    func showOnboardingFlow() {
        // try to get navigation controller
        
        guard let navigationController = navigationController else { return }
        // if success create OnboardingCoordinator
        
        let onboardingCoordinator = OnboardingCoordinator(
            type: .onboarding,
            navigationController: navigationController,
            finishDelegate: self)
        
        // add OnboardingCoordinator to childs
        addChildCoordinator(onboardingCoordinator)
        
        onboardingCoordinator.start()
    }
    
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        homeCoordinator.finishDelegate = self
        homeCoordinator.start()
        
        let wardrobeNavigationController = UINavigationController()
        let wardrobeCoordinator = WardrobeCoordinator(type: .wardrobe, navigationController: wardrobeNavigationController)
        wardrobeNavigationController.tabBarItem = UITabBarItem(title: "Wardrobe", image: UIImage(systemName: "hanger"), tag: 1)
        wardrobeCoordinator.finishDelegate = self
        wardrobeCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .profile, navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 2)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()
        
        addChildCoordinator(homeCoordinator)
        addChildCoordinator(wardrobeCoordinator)
        addChildCoordinator(profileCoordinator)
        
        let tabBarControllers = [homeNavigationController, wardrobeNavigationController, profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator coordinator: CoordinatorProtocol) {
        removeChildCoordinator(coordinator)

        switch coordinator.type {
        case .onboarding:
            navigationController?.viewControllers.removeAll()
            showMainFlow()
        case .app: 
            return
        default:
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
