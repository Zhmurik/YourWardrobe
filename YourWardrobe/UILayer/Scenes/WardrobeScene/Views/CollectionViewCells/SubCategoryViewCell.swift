//
//  SubCategoryViewCell.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/14/25.
//

import UIKit

class SubCategoryViewCell: UICollectionViewCell {
    
    let topView = UIView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with subcategory: ClosingSubCategory) {
        imageView.image = subcategory.image
        titleLabel.text = subcategory.rawValue
    }
    
    func setupCell() {
//        contentView.backgroundColor = AppColors.testColor1
        setupTopView()
        setupImageView()
        setupBottomLabel()
    }
    
    func setupTopView() {
        contentView.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = AppColors.testColor2
        topView.layer.cornerRadius = 20
        topView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            topView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.widthAnchor.constraint(equalToConstant: 100),
            topView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    func setupImageView() {
        topView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            
            imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    func setupBottomLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.font = .Oswald.Regular.size(size: 14)
        titleLabel.textColor = AppColors.textPrimary
        titleLabel.text = "Title label"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
        ])
    }

}
