//
//  WRSearchField.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/6/25.
//

import UIKit

class WRSearchField: UITextField {
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.layer.cornerRadius = 24
        self.layer.borderWidth = 1.5
        self.layer.borderColor = AppColors.accentColor.cgColor
        self.font = UIFont.Oswald.Regular.size(size: 14)
        self.placeholder = "Search"
        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
        imageView.image = UIImage(resource: .search)
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20 + 20 + 10, height: 20))
        leftPaddingView.addSubview(imageView)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.height))
        self.leftView = leftPaddingView
        self.rightView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }

}
