//
//  HomeViewController.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/20/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Collection main icons
    lazy var smallHCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 40
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.tag = 1

        return collection
    }()
    
    lazy var bigHCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.tag = 2
        return collection
    }()
    
    lazy var bigVCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = .zero
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.tag = 3
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
   
}
//MARK: Layout
extension HomeViewController {
    func setupLayout(){
        setupView()
        setupSmallHCollection()
        setupBigHCollection()
        setupBigVCollection()
    }
    func  setupView() {
        
    }
    func setupSmallHCollection() {
        view.addSubview(smallHCollection)
        
        smallHCollection.translatesAutoresizingMaskIntoConstraints = false
//        smallHCollection.backgroundColor = .red
        smallHCollection.delegate = self
        smallHCollection.dataSource = self
        smallHCollection.register(SmallHCViewCell.self, forCellWithReuseIdentifier: "SmallHCViewCell")
        
        
        NSLayoutConstraint.activate([
            smallHCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            smallHCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            smallHCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            smallHCollection.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    func setupBigHCollection() {
        view.addSubview(bigHCollection)
        
        bigHCollection.translatesAutoresizingMaskIntoConstraints = false
        bigHCollection.delegate = self
        bigHCollection.dataSource = self
        bigHCollection.register(BigHCViewCell.self, forCellWithReuseIdentifier: "BigHCViewCell")
        
        
        NSLayoutConstraint.activate([
            bigHCollection.topAnchor.constraint(equalTo: smallHCollection.bottomAnchor, constant: 100),
            bigHCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            bigHCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bigHCollection.heightAnchor.constraint(equalToConstant: 130*2+20),
        ])
    }
    
    func setupBigVCollection() {
        view.addSubview(bigVCollection)
        
        bigVCollection.translatesAutoresizingMaskIntoConstraints = false
        bigVCollection.delegate = self
        bigVCollection.dataSource = self
        bigVCollection.register(BigVCViewCell.self, forCellWithReuseIdentifier: "BigVCViewCell")
        
        
        NSLayoutConstraint.activate([
            bigVCollection.topAnchor.constraint(equalTo: bigHCollection.bottomAnchor, constant: 50),
            bigVCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bigVCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            bigVCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - CollectionView delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return 6
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallHCViewCell", for: indexPath)
                return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigHCViewCell", for: indexPath)
                return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigVCViewCell", for: indexPath)
                return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
