//
//  ClosingItem.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/24/25.
//
import Foundation
import UIKit


enum ClosingMainCategory: String, Codable, CaseIterable {
    case clothes = "Clothes"
    case shoes = "Shoes"
    case accessories = "Accessories"
    case bags = "Bags"
    case seasonal = "Seasonal"
    
    func avaliableSubCategories() -> [ClosingSubCategory] {
        switch self {
        case .clothes:
            return [.dresses, .tops, .shirts, .sweaters, .cardiganBlazers, .tShirt, .pants, .jeans, .skirt, .shorts, .jampsuits]
        case .shoes:
            return [.ballerinaFlats, .loafers, .heels, .sneakers, .boots, .sandals, .slippersFlats, .espadrilles, .boots, .mules]
        case .accessories:
            return [.scarves, .hats, .jewelry, .sunglasses, .belts, .hairAccessories]
        case .bags:
            return [.backpack, .shoppers, .crossbodyBag, .toteBag, .clutchBag, .waistBag, .eveningBag]
        case .seasonal:
            return []
        }
    }
}

enum ClosingSubCategory: String, Codable, CaseIterable {
    case dresses = "Dresses"
    case tops = "Tops"
    case shirts = "Shirt"
    case sweaters = "Sweaters"
    case cardiganBlazers = "Cardigan/Blazers"
    case tShirt = "T-Shirt"
    case pants = "Pants"
    case jeans = "Jeans"
    case skirt = "Skirt"
    case shorts = "Shorts"
    case jampsuits = "Jumpsuits"
    
    case loafers = "Loafers"
    case heels = "Heels"
    case sneakers = "Sneakers"
    case boots = "Boots"
    case sandals = "Sandals"
    case slippersFlats = "Slippers&Flats"
    case espadrilles = "Espadrilles"
    case mules = "Mules"
    case ballerinaFlats = "Ballerina Flats"
    case brogues = "Brogues"

    case scarves = "Scarves"
    case hats = "Hats"
    case belts = "Belts"
    case jewelry = "Jewelry"
    case hairAccessories = "Hair Accessories"
    case sunglasses = "Sunglasses"
    
    case shoppers = "Shoppers Bag"
    case crossbodyBag = "Crossbody Bag"
    case toteBag = "Tote Bag"
    case clutchBag = "Clutch Bag"
    case eveningBag = "Evening Bag"
    case backpack = "Backpack"
    case waistBag = "Waist Bag"
}

enum Season: String, CaseIterable, Codable {
    case summer = "Summer"
    case winter = "Winter"
    case spring = "Spring"
    case autumn = "Autumn"
    case allSeasons = "All Seasons"
}

struct ClothingItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var category: ClosingMainCategory
    var subcategory: ClosingSubCategory
    var color: String
    var season: Season
    var note: String?
    var imageData: Data? 

    var image: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}
