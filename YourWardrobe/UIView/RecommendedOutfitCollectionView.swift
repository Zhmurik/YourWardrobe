//
//  RecommendetOutfitCollectionView.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/19/25.
//

import UIKit

class RecommendedOutfitCollectionView: UIView {

    private let scrollDirection: UICollectionView.ScrollDirection
    private var items: [String] = []

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = scrollDirection == .horizontal ? 100 : 20
        layout.minimumInteritemSpacing = scrollDirection == .horizontal ? 30 : 20
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(RecommOutfitViewCell.self, forCellWithReuseIdentifier: "RecommOutfitViewCell")
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.tag = 3
        return collection
    }()

    // MARK: - Init
    init(scrollingDirection: UICollectionView.ScrollDirection) {
        self.scrollDirection = scrollingDirection
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public API
    func setItems(_ items: [String]) {
        self.items = items
        collectionView.reloadData()
    }

    func requiredHeight() -> CGFloat {
        guard scrollDirection == .vertical else {
            return 300
        }

        var totalHeight: CGFloat = 0
        for index in 0..<items.count {
            let indexPath = IndexPath(item: index, section: 0)
            let size = self.collectionView(collectionView, layout: layout, sizeForItemAt: indexPath)
            totalHeight += size.height
        }

        let spacing = CGFloat(max(items.count - 1, 0)) * layout.minimumLineSpacing
        return totalHeight + spacing
    }

    func setBottomInset(_ value: CGFloat) {
        collectionView.contentInset.bottom = value

        if #available(iOS 13.0, *) {
            collectionView.verticalScrollIndicatorInsets.bottom = value
        } else {
            collectionView.scrollIndicatorInsets.bottom = value
        }
    }

    // MARK: - Layout
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

// MARK: - DataSource & Delegate
extension RecommendedOutfitCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommOutfitViewCell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if scrollDirection == .horizontal {
            return CGSize(width: 40, height: 130)
        } else {
            return CGSize(width: collectionView.bounds.width - 40, height: 130)
        }
    }
}
