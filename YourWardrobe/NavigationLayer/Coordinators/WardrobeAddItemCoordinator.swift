//
//  AddItemCoordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/17/25.
//

import UIKit

class WardrobeAddItemCoordinator: Coordinator {
    
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .green
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

