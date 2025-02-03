//
//  OnboardingCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/1/25.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    override func start() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

