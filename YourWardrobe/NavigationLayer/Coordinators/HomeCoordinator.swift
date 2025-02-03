//
//  HomeCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/2/25.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = AppColors.background
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

