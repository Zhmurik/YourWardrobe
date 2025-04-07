//
//  ProfilePresenter.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 4/1/25.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func displayUserData(name: String, city: String?, gender: Gender)
    func showSuccessMessage()
    func showError(_ message: String)
    func navigateToLogin()
    func showEmptyProfileEditor()
}

class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    private var user: UserProfileModel?
    private let userProfileService = UserProfileService()

    init(view: ProfileViewProtocol) {
        self.view = view
    }

    func loadUserData() {
        Task {
            do {
                let updatedUser = try await userProfileService.fetchUserProfileAsync()
                self.user = updatedUser

                let isEmptyProfile = updatedUser.name.isEmpty &&
                                     updatedUser.city == nil &&
                                     updatedUser.gender == .notSpecified

                await MainActor.run {
                    if isEmptyProfile {
                        self.view?.showEmptyProfileEditor()
                    } else {
                        self.view?.displayUserData(
                            name: updatedUser.name,
                            city: updatedUser.city,
                            gender: updatedUser.gender
                        )
                    }
                }

            } catch {
                await MainActor.run {
                    self.view?.showError("Failed to load user data")
                }
            }
        }
    }


    func updateUser(name: String, city: String?, gender: Gender) {
        Task {
            do {
                var fields: [String: Any] = ["name": name, "gender": gender.rawValue]
                if let city = city {
                    fields["city"] = city
                }
                try await userProfileService.updateUserProfileFieldsAsync(fields)
                await MainActor.run {
                    self.view?.showSuccessMessage()
                    self.loadUserData()
                }
            } catch {
                await MainActor.run {
                    self.view?.showError("Failed to update user")
                }
            }
        }
    }

    func logout() {
        Task {
            do {
                try await AuthService.shared.logout()
                await MainActor.run {
                    view?.navigateToLogin()
                }
            } catch {
                await MainActor.run {
                    view?.showError("Failed to log out")
                }
            }
        }
    }
}
