//
//  LoginViewController.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/9/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let bottomView = BottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupLayout()
        
        bottomView.button1Action = gmailPress
        bottomView.button2Action = facebookPress
        
    }
    
    func gmailPress() {
        print("Gmail")
    }
    
    func facebookPress() {
        print("Facebook")
    }
}

private extension LoginViewController {
    func setupLayout() {
        setupBottomView()
    }
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
}

#Preview("LoginVC") {
    LoginViewController()
}
