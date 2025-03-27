//
//  Untitled.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/26/25.
//

import UIKit

protocol CategoryCollectionViewDelegate: AnyObject {
    func didSelectCategory(at indexPath: IndexPath)
}

class CategoryCollectionView: UIView {
    
    weak var delegate: CategoryCollectionViewDelegate?
    var categories: [ClosingMainCategory] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var selectedIndex: IndexPath? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 40
        layout.headerReferenceSize = .zero
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CategoryViewCell.self, forCellWithReuseIdentifier: "CategoryViewCell")
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.tag = 1
        return collection
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCell", for: indexPath) as? CategoryViewCell else {
            return UICollectionViewCell()
        }
        let isSelected = indexPath == selectedIndex
        cell.configure(with: categories[indexPath.item], isSelected: isSelected)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCategory(at: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 91)
    }
}
