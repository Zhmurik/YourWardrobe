//
//  UserProfile.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/27/25.
//

import Foundation

class AuthUser: Identifiable {
    let id: String
    let name: String
    let email: String
    let city: String?

    init(id: String = UUID().uuidString, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
        self.city = nil
    }
}
