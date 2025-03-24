//
//  LocationGeoView.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/23/25.
//

import UIKit

class LocationGeoView: UIView {
    private let geoMarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = AppColors.testColor2
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Oswald.Regular.size(size: 14)
        label.textColor = AppColors.testColor2
        label.numberOfLines = 0
        label.text = "Evelyn, Sunnyvale, CA"
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupView() {
        backgroundColor = .clear
        
        stackView.addArrangedSubview(geoMarkImage)
        stackView.addArrangedSubview(locationLabel)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
