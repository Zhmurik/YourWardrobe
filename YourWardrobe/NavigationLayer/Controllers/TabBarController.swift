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
        
        tabBar.backgroundColor = AppColors.background
        tabBar.tintColor = AppColors.accentColor
        tabBar.unselectedItemTintColor = AppColors.menuColor
        
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = 80.0
        tabBar.itemSpacing = 50.0
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.Oswald.Regular.size(size: 12)], for: .normal)
    }
}
