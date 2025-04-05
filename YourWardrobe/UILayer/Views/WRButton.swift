//
//  Untitled 2.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/18/25.
//
import UIKit


enum WRButtonColorScemes {
    case white
    case orange
    case grey
}

class WRButton: UIView {
    
    private let button = UIButton()
    var action: (() -> Void)?
    var scheme: WRButtonColorScemes = .white {
        didSet {
            setColorScheme(scheme: scheme)
        }
    }
    
    init(scheme: WRButtonColorScemes = .white) {
        super.init(frame: .zero)
        self.scheme = scheme
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        setupButton()
    }
    
    private func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.Oswald.Bold.size(size:18)
        button.layer.cornerRadius = 24
        button.isEnabled = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
                NSLayoutConstraint.activate([
                    button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    button.topAnchor.constraint(equalTo: self.topAnchor)
                ])
                
            }
            
    @objc func buttonPressed() {
        guard let action = action else { return }
            action()
        }
            
    private func setColorScheme(scheme: WRButtonColorScemes) {
        print("Updating color scheme to: \(scheme)") 
        switch scheme {
        case .white:
            button.backgroundColor = AppColors.testColor2
            button.setTitleColor(AppColors.textPrimary, for: .normal)
        case .orange:
            button.backgroundColor = AppColors.accentColor
            button.setTitleColor(.white, for: .normal)
        case .grey:
            button.backgroundColor = AppColors.textPrimary
            button.setTitleColor(AppColors.background, for: .normal)
        }
    }
            
    public func setTitle(_ title: String?) {
        button.setTitle(title, for: .normal)
    }
}
