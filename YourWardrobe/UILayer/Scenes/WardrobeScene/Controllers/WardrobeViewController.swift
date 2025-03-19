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
    private let searchBar = WRSearchField()
    private let geoMarkImage = UIImageView()
    
    var selectedCategoryIndex: IndexPath?
    
    private let subCategoryCollectionTitle = WRCollectionTitle(title: "Category")
    private let recomendCollectionTitle = WRCollectionTitle(title: "Recommended Outfit")
    private let geoLabel = UILabel()
    
    private let recommendedOutfitView = RecommendedOutfitCollectionView()
    
    // MARK: - Collection main icons
    lazy var categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 40
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.tag = 1

        return collection
    }()
    lazy var subCategoryCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.tag = 2
        return collection
    }()
    
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
        setupLayout()
    }
}

//MARK: Layout
extension WardrobeViewController {
    func setupLayout(){
        configureScrollView()
        configureContentView()
        prepareScrollView()
        configureSearchBar()
        configureGeoMark()
        configureGeoLabel()
        setupView()
        setupCategoryCollection()
        configureCategoryCollectionTitle()
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
    func configureGeoMark() {
        contentView.addSubview(geoMarkImage)
        
        geoMarkImage.image = UIImage(resource: .lacationMark)
        
        geoMarkImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            geoMarkImage.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            geoMarkImage.widthAnchor.constraint(equalToConstant: 14),
            geoMarkImage.heightAnchor.constraint(equalToConstant: 20),
            geoMarkImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30)
        ])
    }
    func configureGeoLabel() {
        contentView.addSubview(geoLabel)
        
        geoLabel.text = "Evelyn, Sunnyvale, CA"
        geoLabel.translatesAutoresizingMaskIntoConstraints = false
        geoLabel.numberOfLines = 0
        geoLabel.font = UIFont.Oswald.Regular.size(size: 12)
        geoLabel.textColor = AppColors.menuColor
        
        NSLayoutConstraint.activate([
            geoLabel.centerYAnchor.constraint(equalTo: geoMarkImage.centerYAnchor, constant: 0),
            geoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            geoLabel.leftAnchor.constraint(equalTo: geoMarkImage.rightAnchor, constant: 30),
            geoLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupCategoryCollection() {
        contentView.addSubview(categoryCollection)
        
        categoryCollection.translatesAutoresizingMaskIntoConstraints = false
        categoryCollection.backgroundColor = .clear
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection.register(CategoryViewCell.self, forCellWithReuseIdentifier: "CategoryViewCell")
        categoryCollection.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            categoryCollection.topAnchor.constraint(equalTo: geoMarkImage.topAnchor, constant: 70),
            categoryCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            categoryCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollection.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    func setupSubCategoryCollection() {
        contentView.addSubview(subCategoryCollection)
        
        subCategoryCollection.translatesAutoresizingMaskIntoConstraints = false
        subCategoryCollection.backgroundColor = .clear
        subCategoryCollection.delegate = self
        subCategoryCollection.dataSource = self
        subCategoryCollection.register(SubCategoryViewCell.self, forCellWithReuseIdentifier: "SubCategoryViewCell")
        subCategoryCollection.showsHorizontalScrollIndicator = false
        
        
        NSLayoutConstraint.activate([
            subCategoryCollection.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 70),
            subCategoryCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            subCategoryCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subCategoryCollection.heightAnchor.constraint(equalToConstant: 130*2+20),
        ])
    }
    func configureCategoryCollectionTitle() {
        contentView.addSubview(subCategoryCollectionTitle)
        subCategoryCollectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subCategoryCollectionTitle.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 45),
            subCategoryCollectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            subCategoryCollectionTitle.heightAnchor.constraint(equalToConstant: -22),
            subCategoryCollectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
    func configureRecommendCollectionTitle() {
        contentView.addSubview(recomendCollectionTitle)
        recomendCollectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recomendCollectionTitle.topAnchor.constraint(equalTo: subCategoryCollection.bottomAnchor, constant: 30),
            recomendCollectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            recomendCollectionTitle.heightAnchor.constraint(equalToConstant: -22),
            recomendCollectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }

    func setupRecommendCollection() {
        print("Collection setup")
        contentView.addSubview(recommendedOutfitView)
        
        recommendedOutfitView.translatesAutoresizingMaskIntoConstraints = false
        recommendedOutfitView.configure(delegate: self, dataSource: self)
        
        NSLayoutConstraint.activate([
            recommendedOutfitView.topAnchor.constraint(equalTo: recomendCollectionTitle.bottomAnchor, constant: 26),
            recommendedOutfitView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            recommendedOutfitView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            recommendedOutfitView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func calculateContentSize() {
        var totalHeight: CGFloat = 300 + 50 + 50 + 22 + 22 + 30 + 30 + 30 + categoryCollection.bounds.height + subCategoryCollection.bounds.height
        
        for index in 0..<recommendedOutfitView.collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: index, section: 0)
            let cellHeight = collectionView(recommendedOutfitView.collectionView, layout: recommendedOutfitView.collectionView.collectionViewLayout, sizeForItemAt: indexPath).height
            totalHeight += cellHeight
        }
        
        let spacing = CGFloat(recommendedOutfitView.collectionView.numberOfItems(inSection: 0) - 1) * 30
        
        contentView.heightAnchor.constraint(equalToConstant: totalHeight + spacing).isActive = true
    }
}

//MARK: - CollectionView delegate
extension WardrobeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return presenter.maincategoryData.count
        case 2:
            return 10
        case 3:
            return 8
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let category = presenter.maincategoryData[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCell", for: indexPath) as? CategoryViewCell
            
            let isSelected = (indexPath == selectedCategoryIndex)
            cell?.configure(with: category, isSelected: isSelected)
            
            return cell ?? UICollectionViewCell()
        case 2:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryViewCell", for: indexPath)
        case 3:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "ReccomOutfitViewCell", for: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            if selectedCategoryIndex == indexPath {
                selectedCategoryIndex = nil
            } else {
                selectedCategoryIndex = indexPath
            }
            
            collectionView.reloadData()
            
        case 2:
            print("Subcategory selected")
        case 3:
            print("Recommended outfit selected")
        default:
            print("Unknown selection")
        }
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
