//
//  Untitled.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/14/25.
//
import Foundation

protocol WardrobePresenterProtocol: AnyObject {
    var maincategoryData: [WardrobeMainCategory] { get }
//    var subcategoryData: [WardrobeSubCategory] { get }
//    var recommendedOutfitData: [RecommendedOutfit] { get }
    func getSelectedCategory() -> WardrobeMainCategory
}


class WardrobePresenter:WardrobePresenterProtocol {
    
    // MARK: - Properties
    let coordinator: WardrobeCoordinator
    var maincategoryData = [WardrobeMainCategory]()
    
    // MARK: - Initializers
    init(coordinator: WardrobeCoordinator) {
        self.coordinator = coordinator
        getCategoryData()
    }
    
    // MARK: - Methods
    func getSelectedCategory() -> WardrobeMainCategory {
        return .clothes
    }
    
    private func getCategoryData() {
        // Mock data
        maincategoryData = [.clothes, .shoes, .accessories, .bags, .seasonal]
    }
}
