//
//  ViewController.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 1/31/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let label = UILabel()
        label.text = "Your Wardrobe"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
                                      
        ])
        
        label.font = UIFont.Oswald.SemiBold.size(size: 40)
        label.textColor = AppColors.textPrimary
        
        view.backgroundColor = AppColors.background
    }


}

