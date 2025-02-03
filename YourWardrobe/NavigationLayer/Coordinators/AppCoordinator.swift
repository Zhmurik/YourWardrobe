//
//  AppCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/1/25.
//

import UIKit

class AppCoordinator: Coordinator {
    override func start() {
        showOnboardingFlow()
//        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

// MARK: - Navigation methods
private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = OnboardingCoordinator(
            type: .onboarding,
            navigationController: navigationController)
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

extension AppCoordinator: FinishCoordinatorDelegate {
    func coordinatorDidFinish(_ coordinator: CoordinatorProtocol) {
        removeChildCoordinator(coordinator)

        switch coordinator.type {
        case .app:
            return
        default:
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
