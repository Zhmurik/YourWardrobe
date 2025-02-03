//
//  ProfileCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/2/25.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .yellow
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

