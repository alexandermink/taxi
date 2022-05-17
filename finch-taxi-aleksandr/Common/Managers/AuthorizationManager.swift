//
//  AuthorizationManager.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 21.03.2022.
//

import Foundation

protocol AuthorizationManagerInput {
    var isAuthorized: Bool { get }
    
    func authorized(withToken token: String)
    func logout(userInfo: UserInfo, completion: @escaping (Error) -> Void)
    func clearAuthorizationToken()
}

final class AuthorizationManager {
    
    // MARK: - Properties
    
    var isAuthorized: Bool {
        keychainWrapper.authorizationToken != nil
    }
    
    private let appCoordinator: AppCoordinatorInput
    private let keychainWrapper: KeychainWrapper
    private let userDefaults: UserDefaults
    private let imageService: ImageServiceInput
    
    
    // MARK: - Init
    
    init(appCoordinator: AppCoordinatorInput,
         keychainWrapper: KeychainWrapper,
         userDefaults: UserDefaults,
         imageService: ImageServiceInput) {
        
        self.appCoordinator = appCoordinator
        self.keychainWrapper = keychainWrapper
        self.userDefaults = userDefaults
        self.imageService = imageService
    }
    
}


// MARK: - AuthorizationManagerInput
extension AuthorizationManager: AuthorizationManagerInput {
    
    func authorized(withToken token: String) {
        keychainWrapper.authorizationToken = token
    }
    
    func logout(userInfo: UserInfo, completion: @escaping (Error) -> Void) {
        
        imageService.clearImagesDirectory(completion: completion)
        userDefaults.userInfo = nil
        keychainWrapper.authorizationToken = nil
        appCoordinator.showNeededFlow()
    }
    
    func clearAuthorizationToken() {
        if !userDefaults.isAppRunBefore {
            keychainWrapper.authorizationToken = nil
            userDefaults.isAppRunBefore = true
        }
    }
    
}
