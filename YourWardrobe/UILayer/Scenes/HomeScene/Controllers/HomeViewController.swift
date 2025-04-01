//
//  HomeViewController.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/20/25.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
        
    private var presenter: HomePresenter!
    
    // MARK: - UI Elements
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    
    private let profileIcon = UIImageView()
    private let userNameLabel = UILabel()
    
    private let findLookLabel = UILabel()
    private let findYourLookToday = UIImageView()
    
    private let recommendedTitle = WRCollectionTitle(title: "Recommended Outfit")
    private let recommededOutfitViewCollection = RecommendedOutfitCollectionView(scrollingDirection: .horizontal)
    
    private let weatherView = WeatherView()
    private let locationView = LocationGeoView()
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        presenter = HomePresenter(view: self)
        setupLayout()
        presenter.loadUserName()
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
        setupWeatherAndLocation()
        setupRecommendedSection()
    }
    
    func  setupView() {
        navigationController?.navigationBar.isHidden = true
    }
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
    }
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
        userNameLabel.textColor = AppColors.textPrimary.withAlphaComponent(0.8)
        
        NSLayoutConstraint.activate([
            userNameLabel.centerYAnchor.constraint(equalTo: profileIcon.centerYAnchor, constant: 0),
            userNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            userNameLabel.leftAnchor.constraint(equalTo: profileIcon.rightAnchor, constant: 30),
            userNameLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    func showUserName(_ name: String) {
        DispatchQueue.main.async {
            self.userNameLabel.text = name
        }
    }
    
    func setupFindYourLookLabel() {
        contentView.addSubview(findLookLabel)
        findLookLabel.translatesAutoresizingMaskIntoConstraints = false
        findLookLabel.text = "Find your look"
        findLookLabel.font = UIFont.Oswald.Bold.size(size: 22)
        findLookLabel.textColor = AppColors.textPrimary
        
        NSLayoutConstraint.activate([
            findLookLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 100),
            findLookLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    func setupFindYourLookButton() {
        contentView.addSubview(findYourLookToday)
        
        findYourLookToday.translatesAutoresizingMaskIntoConstraints = false
        findYourLookToday.image = UIImage(resource: .yourlook)
        findYourLookToday.transform = CGAffineTransform(rotationAngle: 3 * .pi / 2)
        findYourLookToday.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(findYourLookTodayTapped))
        findYourLookToday.addGestureRecognizer(tapGesture)
        print("Adding tap gesture to findYourLookToady")

        NSLayoutConstraint.activate([
            findYourLookToday.topAnchor.constraint(equalTo: findLookLabel.bottomAnchor),
            findYourLookToday.widthAnchor.constraint(equalToConstant: 250),
            findYourLookToday.heightAnchor.constraint(equalToConstant: 300),
            findYourLookToday.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            findYourLookToday.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
            ])
    }
    @objc func findYourLookTodayTapped() {
        print("Find Your Look button tapped!")
    }

    func setupWeatherAndLocation() {
        let stackView = UIStackView(arrangedSubviews: [locationView, weatherView])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fill

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: findYourLookToday.bottomAnchor, constant: 5),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])

        weatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherView.widthAnchor.constraint(equalToConstant: 70),
            weatherView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        locationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationView.widthAnchor.constraint(equalToConstant: 200),
            locationView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    func setupRecommendedSection() {
        recommendedTitle.translatesAutoresizingMaskIntoConstraints = false
        recommededOutfitViewCollection.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(recommendedTitle)
        contentView.addSubview(recommededOutfitViewCollection)
        

        NSLayoutConstraint.activate([
            recommendedTitle.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 32),
            recommendedTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            recommendedTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),

            recommededOutfitViewCollection.topAnchor.constraint(equalTo: recommendedTitle.bottomAnchor, constant: 16),
            recommededOutfitViewCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            recommededOutfitViewCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            recommededOutfitViewCollection.heightAnchor.constraint(equalToConstant: 130),

            recommededOutfitViewCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])

        recommededOutfitViewCollection.setItems([
            "Outfit 1", "Outfit 2", "Outfit 3",
            "Outfit 4", "Outfit 5", "Outfit 6",
            "Outfit 7", "Outfit 8", "Outfit 9"
        ])
    }
}
