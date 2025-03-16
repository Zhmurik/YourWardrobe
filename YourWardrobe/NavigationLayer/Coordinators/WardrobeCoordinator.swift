//
//  WardrobeCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/2/25.
//

import UIKit

class WardrobeCoordinator: Coordinator {
//    
//    override func start() {
//        let vc = ViewController()
//        vc.view.backgroundColor = .green
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    override func finish() {
//        print("AppCoordinator finished")
//    }
//}
//
    private let factory = SceneFactory.self
    
    override func start() {
        showWardrobeScene()
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

// MARK: Navigation
extension WardrobeCoordinator {
    func showWardrobeScene() {
        guard let navigationController = navigationController else { return }
        let vc = factory.makeWardrobeScene(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
