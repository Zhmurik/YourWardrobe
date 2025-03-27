//
//  Untitled.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/14/25.
//
import Foundation

protocol WardrobePresenterProtocol: AnyObject {
    var maincategoryData: [ClosingMainCategory] { get }
    var subcategoryData: [ClosingSubCategory] { get set }
//    var recommendedOutfitData: [RecommendedOutfit] { get }
    
    func getSelectedCategory() -> ClosingMainCategory
    func getSubcategories(for category: ClosingMainCategory) -> [ClosingSubCategory]
}


class WardrobePresenter:WardrobePresenterProtocol {

    // MARK: - Properties
    let coordinator: WardrobeCoordinator
    var maincategoryData = [ClosingMainCategory]()
    var subcategoryData = [ClosingSubCategory]()

    
    // MARK: - Initializers
    init(coordinator: WardrobeCoordinator) {
        self.coordinator = coordinator
        getCategoryData()
        subcategoryData = getSubcategories(for: getSelectedCategory())

    }
    
    // MARK: - Methods
    func getSelectedCategory() -> ClosingMainCategory {
        return .clothes
    }
    
    private func getCategoryData() {
        // Mock data
        maincategoryData = [.clothes, .shoes, .accessories, .bags, .seasonal]
    }
    
    func getSubcategories(for category: ClosingMainCategory) -> [ClosingSubCategory] {
        return category.availableSubcategories()
    }
}
