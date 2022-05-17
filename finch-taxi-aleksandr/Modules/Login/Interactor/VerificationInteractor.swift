//
//  VerificationInteractor.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 04.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol VerificationInteractorInput {
    func authorize(
        phoneNumber: String,
        smsCode: String,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}

final class VerificationInteractor {
    
    // MARK: - Properties
    
    private let networkService: AuthorizationNetworkServiceInput
    private let authorizationManager: AuthorizationManagerInput
    
    
    // MARK: - Init
    
    init(networkService: AuthorizationNetworkServiceInput, authorizationManager: AuthorizationManagerInput) {
        self.networkService = networkService
        self.authorizationManager = authorizationManager
    }
    
}


// MARK: - VerificationInteractorInput
extension VerificationInteractor: VerificationInteractorInput {
    
    func authorize(phoneNumber: String,
                   smsCode: String,
                   completion: @escaping (Result<Bool, Error>) -> Void) {
        
        networkService.authorize(phoneNumber: phoneNumber, smsCode: smsCode) { [weak self] result in
            switch result {
                
            case .success(let token):
                self?.authorizationManager.authorized(withToken: token)
                completion(.success(true))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
