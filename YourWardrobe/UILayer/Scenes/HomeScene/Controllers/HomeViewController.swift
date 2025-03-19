//
//  HomeViewController.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/20/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Elements
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    
    private let profileIcon = UIImageView()
    private let userNameLabel = UILabel()
    private let findLookLabel = UILabel()
    private let findYourLookToday = UIImageView()
    
    private let recommendedTitle = WRCollectionTitle(title: "Recommended Outfit")
    private var recommendedCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 40
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }()
    private let weatherIcon = UIImageView()
    private let weatherLabel = UILabel()
    
    // MARK: - Initializers
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        self.recommendedCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupLayout()
        view.layoutIfNeeded()
    }
}
    
extension HomeViewController {
    func setupLayout() {
        configureScrollView()
        configureContentView()
        prepareScrollView()
        setupView()
        setupProfileImageView()
        setupNameLabel()
        setupFindYourLookLabel()
        setupFindYourLookButton()
    }
    
    func  setupView() {
        navigationController?.navigationBar.isHidden = true
    }
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
        
//        scrollView.delaysContentTouches = false
        
    }
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
//        contentView.isUserInteractionEnabled = false

    }
    func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupProfileImageView() {
        contentView.addSubview(profileIcon)
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        profileIcon.image = UIImage(systemName: "person.crop.circle")
        profileIcon.tintColor = AppColors.testColor2
        
        NSLayoutConstraint.activate([
            profileIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            profileIcon.widthAnchor.constraint(equalToConstant: 80),
            profileIcon.heightAnchor.constraint(equalToConstant: 80),
            profileIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30)
        ])
    }
    func setupNameLabel() {
        contentView.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.text = "John Doe"
        userNameLabel.font = UIFont.Oswald.Regular.size(size: 16)
        userNameLabel.textColor = AppColors.menuColor
        
        NSLayoutConstraint.activate([
            userNameLabel.centerYAnchor.constraint(equalTo: profileIcon.centerYAnchor, constant: 0),
            userNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            userNameLabel.leftAnchor.constraint(equalTo: profileIcon.rightAnchor, constant: 30),
            userNameLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupFindYourLookLabel() {
        contentView.addSubview(findLookLabel)
        findLookLabel.translatesAutoresizingMaskIntoConstraints = false
        findLookLabel.text = "Find your look"
        findLookLabel.font = UIFont.Oswald.Regular.size(size: 24)
        findLookLabel.textColor = AppColors.menuColor
        
        NSLayoutConstraint.activate([
            findLookLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 100),
            findLookLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    func setupFindYourLookButton() {
        contentView.addSubview(findYourLookToday)
        
        findYourLookToday.translatesAutoresizingMaskIntoConstraints = false
        findYourLookToday.image = UIImage(resource: .looktoday)
        findYourLookToday.transform = CGAffineTransform(rotationAngle: .pi / 2)
        findYourLookToday.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(findYourLookTodayTapped))
        findYourLookToday.addGestureRecognizer(tapGesture)
        print("Adding tap gesture to findYourLookToady")

        NSLayoutConstraint.activate([
            findYourLookToday.topAnchor.constraint(equalTo: findLookLabel.bottomAnchor, constant: 8),
            findYourLookToday.widthAnchor.constraint(equalToConstant: 250),
            findYourLookToday.heightAnchor.constraint(equalToConstant: 300),
            findYourLookToday.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            findYourLookToday.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
            ])
        
    }
    @objc func findYourLookTodayTapped() {
        print("Find Your Look button tapped!")
    }

}
