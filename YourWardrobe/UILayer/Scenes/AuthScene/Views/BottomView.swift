//
//  BottomView.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/9/25.
//

import UIKit

class BottomView: UIView {
    
    private let label = UILabel()
    private let view1 = UIView()
    private let view2 = UIImageView()
    private let button1 = UIButton()
    private let button2 = UIButton()
    
    var button1Action: (() -> Void)?
    var button2Action: (() -> Void)?
    
    init () {
        super.init (frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = AppColors.background
        setupLabel()
        setupView1()
        setupView2()
        setupButton1()
        setupButton2()
    }
    
    private func setupLabel() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Or connect with"
        label.font = .Oswald.Regular.size(size: 18)
        label.textColor = AppColors.textPrimary
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
    }
    private func setupView1() {
        self.addSubview(view1)
        view1.backgroundColor = AppColors.accentColor
        view1.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            view1.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0),
            view1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -12),
            view1.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    private func setupView2() {
        self.addSubview(view2)
        view2.image = UIImage(named: "auth-wardrobe")
        view2.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: -60),
            view2.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -80/2),
            view2.heightAnchor.constraint(equalToConstant: 250),
            view2.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupButton1() {
        self.addSubview(button1)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.setImage(UIImage(named: "gmail-icon"), for: .normal)
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            button1.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            button1.heightAnchor.constraint(equalToConstant: 70),
            button1.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupButton2() {
        self.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.setImage(UIImage(named: "facebook-icon"), for: .normal)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button2.leftAnchor.constraint(equalTo: button1.rightAnchor, constant: -110),
            button2.topAnchor.constraint(equalTo: button1.topAnchor),
            button2.heightAnchor.constraint(equalToConstant: 70),
            button2.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
}

private extension BottomView {
    @objc func button1Tapped() {
        button1Action?()
    }
    @objc func button2Tapped() {
        button2Action?()
    }
}
    


#Preview("BottomView", traits: .fixedLayout(width: 400, height: 150)) {
    BottomView()
}
