//
//  Untitled.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/14/25.
//
import Foundation

protocol WardrobePresenterProtocol: AnyObject {
    var maincategoryData: [ClosingMainCategory] { get }
//    var subcategoryData: [WardrobeSubCategory] { get }
//    var recommendedOutfitData: [RecommendedOutfit] { get }
    func getSelectedCategory() -> ClosingMainCategory
}


class WardrobePresenter:WardrobePresenterProtocol {

    // MARK: - Properties
    let coordinator: WardrobeCoordinator
    var maincategoryData = [ClosingMainCategory]()
    
    // MARK: - Initializers
    init(coordinator: WardrobeCoordinator) {
        self.coordinator = coordinator
        getCategoryData()
    }
    
    // MARK: - Methods
    func getSelectedCategory() -> ClosingMainCategory {
        return .clothes
    }
    
    private func getCategoryData() {
        // Mock data
        maincategoryData = [.clothes, .shoes, .accessories, .bags, .seasonal]
    }
}
