//
//  UserProfileService.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 4/4/25.
//

import FirebaseAuth
import FirebaseFirestore

final class UserProfileService {
    private let db = Firestore.firestore()
    private let collection = "profiles"

    func fetchUserProfile(completion: @escaping (UserProfileModel?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }

        db.collection(collection).document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                print("Error fetching profile: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            let profile = UserProfileModel(dictionary: data)
            completion(profile)
        }
    }

    func saveUserProfile(_ profile: UserProfileModel, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        db.collection(collection).document(uid).setData(profile.toDictionary()) { error in
            if let error = error {
                print("Error saving profile: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    func updateUserProfileFields(_ fields: [String: Any], completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        db.collection(collection).document(uid).updateData(fields) { error in
            if let error = error {
                print("Error updating fields: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    func deleteUserProfile(completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        db.collection(collection).document(uid).delete { error in
            if let error = error {
                print("Profile deletion error: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

}
extension UserProfileService {
    func fetchUserProfileAsync() async throws -> UserProfileModel {
        try await withCheckedThrowingContinuation { continuation in
            fetchUserProfile { profile in
                if let profile = profile {
                    continuation.resume(returning: profile)
                } else {
                    continuation.resume(throwing: NSError(domain: "UserProfileError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Profile not found"]))
                }
            }
        }
    }

    func updateUserProfileFieldsAsync(_ fields: [String: Any]) async throws {
        try await withCheckedThrowingContinuation { continuation in
            updateUserProfileFields(fields) { success in
                if success {
                    continuation.resume()
                } else {
                    continuation.resume(throwing: NSError(domain: "UserProfileError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to update profile"]))
                }
            }
        }
    }
}

