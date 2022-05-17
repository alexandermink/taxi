//
//  AppCoordinator.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 21.03.2022.
//

import UIKit

protocol AppCoordinatorInput {
    func startFlow(onWindow window: UIWindow)
    func showNeededFlow()
}

final class AppCoordinator {
    
    // MARK: - Properties
    
    private lazy var authorizationManager: AuthorizationManagerInput = {
        ManagerFactory.shared.authorizationManager
    }()
    
    private lazy var rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
}


// MARK: - AppCoordinatorInput
extension AppCoordinator: AppCoordinatorInput {
    
    func startFlow(onWindow window: UIWindow) {
        window.rootViewController = rootNavigationController
        showNeededFlow()
    }
    
    func showNeededFlow() {
        
        if authorizationManager.isAuthorized {
            rootNavigationController.viewControllers.append(MainTabBarAssembly.assembleModule(with: MainTabBarAssembly.Model()))
        } else {
            rootNavigationController.viewControllers.append(LoginAssembly.assembleModule())
        }
    }
}
