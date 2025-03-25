//
//  Outfit.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/24/25.
//

import Foundation
import UIKit

struct Outfit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var dateCreated: Date
    var description: String?
    var outfitImageData: Data?
    var items: [ClothingItem]
    var seasons: [Season]

    var outfitImage: UIImage? {
        guard let outfitImageData else { return nil }
        return UIImage(data: outfitImageData)
    }
}
