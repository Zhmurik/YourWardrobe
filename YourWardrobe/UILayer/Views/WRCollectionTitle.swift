//
//  WRCollectionTitle.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/12/25.
//

import UIKit

class WRCollectionTitle: UIView {
    
    let collectionTitle = UILabel()
    let viewAllButton = UIButton()
    
    private let titleText: String
    
    init(title: String) {
        self.titleText = title
        super.init(frame: .zero)
        setupLayout()
        collectionTitle.text = titleText  // Устанавливаем заголовок
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension WRCollectionTitle {
    func setupLayout() {
            configureView()
            configureTitle()
            configureViewAll()
    }
        
    func configureView() {
        self.backgroundColor = .clear
    }
    func configureTitle() {
        addSubview(collectionTitle)
            
        collectionTitle.translatesAutoresizingMaskIntoConstraints = false
        collectionTitle.backgroundColor = .clear
        collectionTitle.textColor = AppColors.textPrimary
        collectionTitle.font = UIFont.Oswald.Bold.size(size: 18)
            
        NSLayoutConstraint.activate([
            collectionTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            collectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionTitle.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    func configureViewAll() {
        addSubview(viewAllButton)
            
        viewAllButton.translatesAutoresizingMaskIntoConstraints = false
        viewAllButton.backgroundColor = .clear
        viewAllButton.setTitle("View All", for: .normal)
        viewAllButton.setTitleColor(AppColors.menuColor, for: .normal)
        viewAllButton.titleLabel?.font = UIFont.Oswald.Bold.size(size: 12)
            
        NSLayoutConstraint.activate([
            viewAllButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            viewAllButton.heightAnchor.constraint(equalToConstant: 22),
            viewAllButton.centerYAnchor.constraint(equalTo: collectionTitle.centerYAnchor),
        ])
    }
}
