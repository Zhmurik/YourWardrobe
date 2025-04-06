//
//  UserProfile.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/27/25.
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case notSpecified = "Not specified"
}

class UserProfileModel: Identifiable {
    let id: String
    let name: String
    let gender: Gender
    let city: String?
    let avatarURL: URL?

    init(id: String = UUID().uuidString, name: String, gender: Gender, city: String? = nil, avatarURL: URL? = nil) {
        self.id = id
        self.name = name
        self.gender = gender
        self.city = city
        self.avatarURL = avatarURL
    }
}

extension UserProfileModel {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "gender": gender.rawValue,
            "city": city ?? "",
            "avatarURL": avatarURL?.absoluteString ?? ""
        ]
    }

    convenience init?(dictionary: [String: Any]) {
        guard
            let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let genderString = dictionary["gender"] as? String,
            let gender = Gender(rawValue: genderString)
        else {
            return nil
        }

        let city = dictionary["city"] as? String
        let avatarString = dictionary["avatarURL"] as? String
        let avatarURL = avatarString.flatMap { URL(string: $0) }

        self.init(id: id, name: name, gender: gender, city: city, avatarURL: avatarURL)
    }
}
