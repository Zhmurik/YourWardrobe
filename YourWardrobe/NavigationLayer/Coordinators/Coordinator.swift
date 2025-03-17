//
//  Coordinator.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/1/25.
//
import UIKit

enum CoordinatorType {
    case app
    case onboarding
    case home
    case wardrobe
    case profile
    case login
    case wardrobeAddItem
}

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    
    var navigationController: UINavigationController? { get set}
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

protocol TabBarCoordinator: AnyObject, CoordinatorProtocol {
    var tabBarController: UITabBarController? { get set }
}
extension CoordinatorProtocol {
    func addChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter{ $0 !== coordinator}
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

class Coordinator: CoordinatorProtocol {
    func start() {
        print("Coordinator started")
    }
    
    func finish() {
        print("Coordinator finished")
    }
    
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType
    var navigationController: UINavigationController?
    var window: UIWindow?
    var finishDelegate: CoordinatorFinishDelegate?
    
    init(childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](),
         type: CoordinatorType,
         navigationController: UINavigationController,
         finishDelegate: CoordinatorFinishDelegate? = nil, window: UIWindow? = nil) {
        self.childCoordinators = childCoordinators
        self.type = type
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
        self.window = window
    }

    deinit {
        print("Coordinator deiniеted \(type)")
        childCoordinators.forEach { $0.finishDelegate = nil }
        childCoordinators.removeAll()
    }
}
