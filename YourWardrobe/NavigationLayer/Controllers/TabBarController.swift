//
//  TabBarController.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/2/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        for tab in tabBarControllers {
            self.addChild(tab)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tabBar.backgroundColor = AppColors.background
        tabBar.tintColor = AppColors.accentColor
        tabBar.unselectedItemTintColor = AppColors.menuColor
    }
}
