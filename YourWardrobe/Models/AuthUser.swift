//
//  UserProfile.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/27/25.
//
import Foundation

struct AuthCredentials {
    var email: String
    var password: String
    var reenteredPassword: String?

    var isValidForSignIn: Bool {
        !email.isEmpty && !password.isEmpty
    }

    var isValidForSignUp: Bool {
        !email.isEmpty && !password.isEmpty && password == reenteredPassword
    }
}

extension AuthCredentials {
    var representation: [String: Any] {
        var representation: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        if let reenteredPassword = reenteredPassword {
            representation["password_confirmation"] = reenteredPassword
        }
        
        return representation
    }
}
