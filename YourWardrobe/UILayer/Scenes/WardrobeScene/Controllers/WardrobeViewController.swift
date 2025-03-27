//
//  WardrobeViewController.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/14/25.
//

import UIKit

class WardrobeViewController: UIViewController {


    // MARK: - Properies
    var presenter: WardrobePresenterProtocol
    
    // MARK: - Views
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let weatherView = WeatherView()
    private let locationView = LocationGeoView()
    
    private let searchBar = WRSearchField()
    
    var selectedCategoryIndex: IndexPath?
    
    private let subCategoryCollectionTitle = WRCollectionTitle(title: "Category")
    private let recomendCollectionTitle = WRCollectionTitle(title: "Recommended Outfit")
    
    // MARK: - Collection main icons
    private let categoryCollectionView = CategoryCollectionView()
    private let subCategoryCollectionView = SubCategoryCollectionView()
    private let recommendedOutfitView = RecommendedOutfitCollectionView(scrollingDirection: .vertical)
    
    // MARK: - Initializers
    init(presenter: WardrobePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifesycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        recommendedOutfitView.collectionView.reloadData()
        categoryCollectionView.delegate = self
        categoryCollectionView.categories = presenter.maincategoryData
        categoryCollectionView.selectedIndex = IndexPath(item: 0, section: 0)

        
        setupLayout()
        
//        DispatchQueue.main.async {
//            let firstIndexPath = IndexPath(item: 0, section: 0)
//            self.categoryCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .left)
//            self.collectionView(self.categoryCollectionView, didSelectItemAt: firstIndexPath)
//        }
    }
}

//MARK: Layout
extension WardrobeViewController {
    func setupLayout(){
        configureScrollView()
        configureContentView()
        prepareScrollView()
        configureSearchBar()
        configureWeatherAndLocation()
        setupView()
        setupCategoryCollection()
        configureSubCategoryCollectionTitle()
        setupSubCategoryCollection()
        configureRecommendCollectionTitle()
        setupRecommendCollection()
        // TODO: Only for mock data
        calculateContentSize()
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
        contentView.backgroundColor = .clear
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
    func configureSearchBar() {
        contentView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureWeatherAndLocation() {
        let stackView = UIStackView(arrangedSubviews: [locationView, weatherView])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fill

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
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
    
    func setupCategoryCollection() {
        contentView.addSubview(categoryCollectionView)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 70),
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setupSubCategoryCollection() {
        contentView.addSubview(subCategoryCollectionView)
        subCategoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        subCategoryCollectionView.delegate = self
        subCategoryCollectionView.subcategories = presenter.subcategoryData
        
        NSLayoutConstraint.activate([
            subCategoryCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 70),
            subCategoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            subCategoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subCategoryCollectionView.heightAnchor.constraint(equalToConstant: 130 * 2 + 20),
        ])
    }

    func configureSubCategoryCollectionTitle() {
        contentView.addSubview(subCategoryCollectionTitle)
        subCategoryCollectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subCategoryCollectionTitle.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 35),
            subCategoryCollectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            subCategoryCollectionTitle.heightAnchor.constraint(equalToConstant: 22),
            subCategoryCollectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
    func configureRecommendCollectionTitle() {
        contentView.addSubview(recomendCollectionTitle)
        recomendCollectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recomendCollectionTitle.topAnchor.constraint(equalTo: subCategoryCollectionView.bottomAnchor, constant: 30),
            recomendCollectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            recomendCollectionTitle.heightAnchor.constraint(equalToConstant: 22),
            recomendCollectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }

    func setupRecommendCollection() {
        contentView.addSubview(recommendedOutfitView)

        recommendedOutfitView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recommendedOutfitView.topAnchor.constraint(equalTo: recomendCollectionTitle.bottomAnchor, constant: 26),
            recommendedOutfitView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            recommendedOutfitView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])

        recommendedOutfitView.setItems([
            "Outfit 1", "Outfit 2", "Outfit 3",
            "Outfit 4", "Outfit 5", "Outfit 6"
        ])

        DispatchQueue.main.async {
            let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 49
            let bottomInset: CGFloat = tabBarHeight + 16
            let height = self.recommendedOutfitView.requiredHeight() + bottomInset
                
            NSLayoutConstraint.activate([
                self.recommendedOutfitView.heightAnchor.constraint(equalToConstant: height)
            ])
            self.recommendedOutfitView.setBottomInset(bottomInset)
        }
    }

    func calculateContentSize() {
        var totalHeight: CGFloat = 300 + 50 + 50 + 22 + 22 + 30 + 30 + 30 + categoryCollectionView.bounds.height + subCategoryCollectionView.bounds.height
        
        for index in 0..<recommendedOutfitView.collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: index, section: 0)
            let cellHeight = collectionView(recommendedOutfitView.collectionView, layout: recommendedOutfitView.collectionView.collectionViewLayout, sizeForItemAt: indexPath).height
            totalHeight += cellHeight
        }
        
        let spacing = CGFloat(recommendedOutfitView.collectionView.numberOfItems(inSection: 0) - 1) * 30
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 49
        let bottomPadding: CGFloat = tabBarHeight + 16
        
        contentView.heightAnchor.constraint(equalToConstant: totalHeight + spacing + bottomPadding).isActive = true
    }
}

//MARK: - CollectionView delegate
extension WardrobeViewController: CategoryCollectionViewDelegate, SubCategoryCollectionViewDelegate {
    func didSelectCategory(at indexPath: IndexPath) {
        selectedCategoryIndex = indexPath
        let selectedCategory = presenter.maincategoryData[indexPath.row]
        presenter.subcategoryData = presenter.getSubcategories(for: selectedCategory)
        subCategoryCollectionView.subcategories = presenter.subcategoryData
        categoryCollectionView.selectedIndex = indexPath
    }
    
    func didSelectedSubcategory(at indexPath: IndexPath) {
        print("Selected subcategory: \(presenter.subcategoryData[indexPath.row])")
    }
}


extension WardrobeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: 70, height: 91)
        case 2:
            return CGSize(width: 130, height: 130)
        case 3:
            let width = collectionView.bounds.width
            let height = 130.0
            return CGSize(width: width, height: height)
        default :
            return CGSize(width: 0, height: 0)
        }
    }
}
