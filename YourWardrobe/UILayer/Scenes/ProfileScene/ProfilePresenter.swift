//
//  ProfilePresenter.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 4/1/25.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func displayUserData(name: String, city: String?)
    func showSuccessMessage()
    func showError(_ message: String)
}

class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    private var user: AuthUser

    init(view: ProfileViewProtocol, user: AuthUser) {
        self.view = view
        self.user = user
    }

    func loadUserData() {
        Task {
            do {
                let updatedUser = try await AuthService.shared.fetchCurrentUserProfile()
                self.user = updatedUser
                await MainActor.run {
                    self.view?.displayUserData(name: updatedUser.name, city: updatedUser.city)
                }
            } catch {
                await MainActor.run {
                    self.view?.showError("Failed to load user data")
                }
            }
        }
    }

    func updateUser(name: String, city: String?) {
        Task {
            do {
                try await AuthService.shared.updateUserProfile(userId: user.id, name: name, city: city)
                await MainActor.run {
                    self.view?.showSuccessMessage()
                }
            } catch {
                await MainActor.run {
                    self.view?.showError("Failed to update user")
                }
            }
        }
    }
}

