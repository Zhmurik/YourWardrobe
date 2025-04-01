//
//  wardrobeViewPresenter.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/14/25.
//

import Foundation
import FirebaseFirestore

protocol HomeViewProtocol: AnyObject {
    func showUserName(_ name: String)
}

class HomePresenter {
    weak var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol?) {
        self.view = view
    }
    
    func loadUserName() {
        Task {
            do {
                guard let uid = await AuthService.shared.currentUser?.uid else {
                    view?.showUserName("Guest")
                    return
                }
                
                let document = try await Firestore.firestore().collection("users").document(uid).getDocument()
                
                if let data = document.data(), let name = data["name"] as? String {
                    view?.showUserName(name)
                } else {
                    view?.showUserName("Guest")
                }
            } catch {
                print("Error: \(error)")
                view?.showUserName("Guest")
            }
        }
    }
}
