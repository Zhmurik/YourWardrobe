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
    
    override var isSelected: Bool {
        didSet {
            updateSelectionState(isSelected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: ClosingMainCategory, isSelected: Bool) {
        imageViewCategory.image = category.image
        bottomLabel.text = category.rawValue
        updateSelectionState(isSelected)
    }

    
    func updateSelectionState(_ isSelected: Bool) {
        topView.backgroundColor = isSelected ? AppColors.accentColor : .clear
        topView.layer.borderColor = isSelected ? AppColors.accentColor.cgColor : AppColors.testColor1.cgColor
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
