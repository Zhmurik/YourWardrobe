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
    
    var image: UIImage {
        switch self {
        case .clothes:
            return UIImage(resource: .wrClothes)
        case .shoes:
            return UIImage(resource: .wrShoes)
        case .accessories:
            return UIImage(resource: .wrAccessories)
        case .bags:
            return UIImage(resource: .wrBags)
        case .seasonal:
            return UIImage(resource: .wrSeasonal)
        }
    }
    
    static let categoryToSubcategories: [ClosingMainCategory: [ClosingSubCategory]] = [
        .clothes: [.dresses, .tops, .shirts, .sweaters, .cardiganBlazers, .tShirt, .pants, .jeans, .skirt, .shorts, .jumpsuits],
        .shoes: [.ballerinaFlats, .loafers, .heels, .sneakers, .boots, .sandals, .slippersFlats, .espadrilles, .mules],
        .accessories: [.scarf, .hats, .jewellery, .sunglasses, .belts, .hairAccessories],
        .bags: [.backpack, .shoppers, .crossbodyBag, .handBag, .clutchBag, .waistBag, .eveningBag],
        .seasonal: []
    ]

        func availableSubcategories() -> [ClosingSubCategory] {
            return ClosingMainCategory.categoryToSubcategories[self] ?? []
        }
}

enum ClosingSubCategory: String, Codable, CaseIterable {
    case dresses = "Dresses"
    case tops = "Tops"
    case shirts = "Shirts"
    case sweaters = "Sweaters"
    case cardiganBlazers = "Cardigan/Blazers"
    case tShirt = "T-Shirt"
    case pants = "Pants"
    case jeans = "Jeans"
    case skirt = "Skirt"
    case shorts = "Shorts"
    case jumpsuits = "Jumpsuits"
    
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

    case scarf = "Scarf"
    case hats = "Hats"
    case belts = "Belts"
    case jewellery = "Jewellery"
    case hairAccessories = "Hair Accessories"
    case sunglasses = "Sunglasses"
    
    case shoppers = "Shoppers Bag"
    case crossbodyBag = "Crossbody Bag"
    case handBag = "Hand Bag"
    case clutchBag = "Clutch Bag"
    case eveningBag = "Evening Bag"
    case backpack = "Backpack"
    case waistBag = "Waist Bag"
    
    var image: UIImage {
        switch self {
        case .dresses:
            return UIImage(resource: .scDress)
        case .tops:
            return UIImage(resource: .scTops)
        case .shirts:
            return UIImage(resource: .scShirts)
        case .sweaters:
            return UIImage(resource: .scSweaters)
        case .cardiganBlazers:
            return UIImage(resource: .scBlazers)
        case .tShirt:
            return UIImage(resource: .scTShirt)
        case .pants:
            return UIImage(resource: .scPants)
        case .jeans:
            return UIImage(resource: .scJeans)
        case .skirt:
            return UIImage(resource: .scSkirt)
        case .shorts:
            return UIImage(resource: .scShort)
        case .jumpsuits:
            return UIImage(resource: .scJumpsuit)
        case .loafers:
            return UIImage(resource: .scLoafers)
        case .heels:
            return UIImage(resource: .scHeel)
        case .sneakers:
            return UIImage(resource: .scSneakers)
        case .boots:
            return UIImage(resource: .scBoots)
        case .sandals:
            return UIImage(resource: .scSandals)
        case .slippersFlats:
            return UIImage(resource: .scSlippersFlats)
        case .espadrilles:
            return UIImage(resource: .scEspadrilles)
        case .mules:
            return UIImage(resource: .scMules)
        case .ballerinaFlats:
            return UIImage(resource: .scBallerinaFlats)
        case .brogues:
            return UIImage(resource: .scBrogues)
        case .scarf:
            return UIImage(resource: .scScarfs)
        case .hats:
            return UIImage(resource: .scHats)
        case .belts:
            return UIImage(resource: .scBelt)
        case .jewellery:
            return UIImage(resource: .scJewellery)
        case .hairAccessories:
            return UIImage(resource: .scHairAccessories)
        case .sunglasses:
            return UIImage(resource: .scSunglasses)
        case .shoppers:
            return UIImage(resource: .scShopperBag)
        case .crossbodyBag:
            return UIImage(resource: .scCrossbodyBag)
        case .handBag:
            return UIImage(resource: .scHandBag)
        case .clutchBag:
            return UIImage(resource: .scClutchBag)
        case .eveningBag:
            return UIImage(resource: .scEveningBag)
        case .backpack:
            return UIImage(resource: .scBackpack)
        case .waistBag:
            return UIImage(resource: .scWaistBag)
        }
    }
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
