//
//  UserStorage.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/7/25.
//

import Foundation

class UserStorage {
    static let shared = UserStorage()
    
    var passedOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: "passedOnboarding")}
        set { UserDefaults.standard.set(newValue, forKey: "passedOnboarding")}
    }
    
    private init() {}
}
