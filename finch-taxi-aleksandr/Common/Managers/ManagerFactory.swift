//
//  ManagerFactory.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 21.03.2022.
//

import Foundation

final class ManagerFactory {
    
    // MARK: - Properties
    
    static let shared = ManagerFactory()
    
    private(set) lazy var appCoordinator: AppCoordinatorInput = AppCoordinator()
    
    var authorizationManager: AuthorizationManagerInput {
        
        AuthorizationManager(
            appCoordinator: appCoordinator,
            keychainWrapper: services.keychainWrapper,
            userDefaults: services.standardUserDefaults,
            imageService: services.imageService
        )
    }
    
    private let services = ServiceFactory.shared
    
    
    // MARK: - Init
    
    private init() {  }
    
}


// MARK: - NSCopying
extension ManagerFactory: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        self
    }
}
