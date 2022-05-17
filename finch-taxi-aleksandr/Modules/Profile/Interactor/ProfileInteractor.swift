//
//  ProfileInteractor.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 22.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol ProfileInteractorInput {
    func getUserInfo(completion: @escaping (UserInfo) -> Void)
    func getImage(forKey key: String) -> UIImage?
    func logout(userInfo: UserInfo, completion: @escaping (Error) -> Void)
}

final class ProfileInteractor {
    
    // MARK: - Properties
    
    private let networkService: ProfileNetworkServiceInput
    private let imageService: ImageServiceInput
    private let userDefaults: UserDefaults
    private let authorizationManager: AuthorizationManagerInput
    
    
    // MARK: - Init
    
    init(networkService: ProfileNetworkServiceInput,
         imageService: ImageServiceInput,
         userDefaults: UserDefaults,
         authorizationManager: AuthorizationManagerInput) {
        
        self.networkService = networkService
        self.imageService = imageService
        self.userDefaults = userDefaults
        self.authorizationManager = authorizationManager
    }
}


// MARK: - ProfileInteractorInput
extension ProfileInteractor: ProfileInteractorInput {
   
    func getUserInfo(completion: @escaping (UserInfo) -> Void) {
        guard let userInfo = userDefaults.userInfo else {
            networkService.getUserInfo(completion: completion)
            return
        }
        completion(userInfo)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        imageService.getImage(forKey: key)
    }
    
    func logout(userInfo: UserInfo, completion: @escaping (Error) -> Void) {
        authorizationManager.logout(userInfo: userInfo, completion: completion)
    }
}
