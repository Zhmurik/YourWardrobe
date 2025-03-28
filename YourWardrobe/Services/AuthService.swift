//
//  AuthService.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/27/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


enum AuthError: Error {
    case invalidInput
    case firebaseError(String)
    case userDataNotFound
    case unknown
}

actor AuthService {
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    var currentUser: User? { auth.currentUser }

    // MARK: - Registration
    func register(credentials: AuthCredentials, name: String) async throws -> AuthUser {
        guard credentials.isValidForSignUp, !name.isEmpty else {
            throw AuthError.invalidInput
        }
        
        let result = try await auth.createUser(withEmail: credentials.email, password: credentials.password)
        let user = result.user
        
        let userData: [String: Any] = [
            "id": user.uid,
            "name": name,
            "email": credentials.email
        ]
        
        try await db.collection("users").document(user.uid).setData(userData)
        
        return AuthUser(id: user.uid, name: name, email: credentials.email)
    }

    // MARK: - Sign In
    func signIn(credentials: AuthCredentials) async throws -> AuthUser {
        guard credentials.isValidForSignIn else {
            throw AuthError.invalidInput
        }

        let result = try await auth.signIn(withEmail: credentials.email, password: credentials.password)
        let user = result.user
        
        let snapshot = try await db.collection("users").document(user.uid).getDocument()
        
        guard let data = snapshot.data(),
              let name = data["name"] as? String,
              let email = data["email"] as? String else {
            throw AuthError.userDataNotFound
        }

        return AuthUser(id: user.uid, name: name, email: email)
    }

    // MARK: - Logout
    func logout() throws {
        try auth.signOut()
    }

    // MARK: - Reset Password
    func resetPassword(for credentials: AuthCredentials) async throws {
        guard !credentials.email.isEmpty else {
            throw AuthError.invalidInput
        }

        try await auth.sendPasswordReset(withEmail: credentials.email)
    }

    // MARK: - Update User Name
    func updateUserName(userId: String, newName: String) async throws {
        guard !newName.isEmpty else {
            throw AuthError.invalidInput
        }

        try await db.collection("users").document(userId).updateData([
            "name": newName
        ])
    }
}
