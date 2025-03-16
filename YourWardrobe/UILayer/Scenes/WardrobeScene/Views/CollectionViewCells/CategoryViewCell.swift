//
//  CatgoryViewCell.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/14/25.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    let topView = UIView()
    let bottomLabel = UILabel()
    let imageViewCategory = UIImageView()
    
    var isCategorySelected = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: WardrobeMainCategory, isSelected: Bool) {
        
        bottomLabel.text = category.rawValue
        updateSelectionState(isSelected)
        
        switch category {
        case .clothes:
            print(category)
            imageViewCategory.image = UIImage(resource: .wrClothes).withTintColor(.black)
        case .shoes:
            imageViewCategory.image = UIImage(resource: .wrShoes).withTintColor(.black)
            print(category)
        case .accessories:
            imageViewCategory.image = UIImage(resource: .wrAccessories).withTintColor(.black)
            print(category)
        case .bags:
            imageViewCategory.image = UIImage(resource: .wrBags).withTintColor(.black)
            print(category)
        case .seasonal:
            imageViewCategory.image = UIImage(resource: .wrSeasonal).withTintColor(.black)
            print(category)
        }
    }
    
    func updateSelectionState(_ isSelected: Bool) {
        topView.backgroundColor = isSelected ? AppColors.accentColor : .clear
    }
    
    func setupCell() {
        contentView.backgroundColor = .clear
        setupTopView()
        setupBottomLabel()
    }
    
    func setupTopView() {
        contentView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
//        topView.backgroundColor = AppColors.testColor2
        topView.layer.borderColor = AppColors.testColor1.cgColor
        topView.layer.borderWidth = 1
        topView.layer.cornerRadius = 20
        topView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            topView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.widthAnchor.constraint(equalToConstant: 70),
            topView.heightAnchor.constraint(equalToConstant: 67),
        ])
        
        imageViewCategory.translatesAutoresizingMaskIntoConstraints = false
        imageViewCategory.contentMode = .scaleAspectFit
        imageViewCategory.clipsToBounds = true
        
        topView.addSubview(imageViewCategory)
        
        NSLayoutConstraint.activate([
            imageViewCategory.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            imageViewCategory.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            imageViewCategory.widthAnchor.constraint(equalToConstant: 67),
            imageViewCategory.heightAnchor.constraint(equalToConstant: 66),
            ])
    }
    func setupBottomLabel() {
        contentView.addSubview(bottomLabel)
        
        bottomLabel.font = .Oswald.Regular.size(size: 14)
        bottomLabel.textColor = AppColors.textPrimary
        bottomLabel.text = "Test label"
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            bottomLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }

}
