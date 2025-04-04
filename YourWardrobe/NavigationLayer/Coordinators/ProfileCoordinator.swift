//
//  ProfileCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/2/25.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    private let factory = SceneFactory.self
    
    override func start() {
        Task { [weak self] in
            await self?.showProfileScene()
        }
    }
    
    override func finish() {
        print("ProfileCoordinator finished")
    }
}

// MARK: - Navigation
extension ProfileCoordinator {
    func showProfileScene() async {
        guard let firebaseUser = await AuthService.shared.currentUser else {
            fatalError("No authenticated user")
        }
        
        await MainActor.run {
            guard let navigationController = navigationController else { return }
            let vc = factory.makeProfileScene(coordinator: self)
            navigationController.pushViewController(vc, animated: true)

        }
    }
}
