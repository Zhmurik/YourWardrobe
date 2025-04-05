//
//  AuthService.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/27/25.
//

import Foundation
import FirebaseAuth

enum AuthError: Error {
    case invalidInput
    case firebaseError(String)
    case userDataNotFound
    case unknown
}

actor AuthService {
    static let shared = AuthService()

    private let auth = Auth.auth()
    
    var currentUser: User? {
        auth.currentUser
    }

    // MARK: - Registration
    func register(credentials: AuthCredentials) async throws -> String {
        guard credentials.isValidForSignUp else {
            throw AuthError.invalidInput
        }

        let result = try await auth.createUser(withEmail: credentials.email, password: credentials.password)
        return result.user.uid
    }

    // MARK: - Sign In
    func signIn(credentials: AuthCredentials) async throws -> String {
        guard credentials.isValidForSignIn else {
            throw AuthError.invalidInput
        }

        let result = try await auth.signIn(withEmail: credentials.email, password: credentials.password)
        return result.user.uid
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

    // MARK: - Change Password
    func changePassword(to newPassword: String) async throws {
        guard let user = auth.currentUser else {
            throw AuthError.userDataNotFound
        }
        guard !newPassword.isEmpty else {
            throw AuthError.invalidInput
        }

        try await user.updatePassword(to: newPassword)
    }
}
