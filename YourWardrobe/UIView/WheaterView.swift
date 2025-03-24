//
//  WheaterView.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/22/25.
//

import UIKit

class WeatherView: UIView {

    // MARK: - UI Elements

    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "thermometer.sun")
        imageView.tintColor = AppColors.menuColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        return imageView
    }()

    private let weatherTemperature: UILabel = {
        let label = UILabel()
        label.text = "23°"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
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

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .clear

        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(weatherTemperature)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Configure

    func configure(with temperature: String, imageName: String) {
        weatherTemperature.text = temperature
        weatherImage.image = UIImage(systemName: imageName)
    }
}
