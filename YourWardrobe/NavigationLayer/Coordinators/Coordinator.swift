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
}

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    var navigationController: UINavigationController? { get set}
    var finishDelegate: FinishCoordinatorDelegate? { get set }
    
    func start()
    func finish()
}

protocol TabBarCoordinator: AnyObject, CoordinatorProtocol {
    var tabBarController: UITabBarController! { get set }
}
extension CoordinatorProtocol {
    func addChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter{ $0 !== coordinator}
    }
}

protocol FinishCoordinatorDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: CoordinatorProtocol)
}

class Coordinator: CoordinatorProtocol {
    func start() {
        print("Coordinates started")
    }
    
    func finish() {
        print("Coordinates finished")
    }
    
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType
    var navigationController: UINavigationController?
    var finishDelegate: FinishCoordinatorDelegate?
    
    init(childCoordinators: [CoordinatorProtocol] = [],
         type: CoordinatorType,
         navigationController: UINavigationController,
         finishDelegate: FinishCoordinatorDelegate? = nil) {
        self.childCoordinators = childCoordinators
        self.type = type
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
    }

    deinit {
        print("Coordinator deinitialized \(type)")
        childCoordinators.forEach { $0.finishDelegate = nil }
        childCoordinators.removeAll()
    }
}
