//
//  LoginInteractor.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 29.03.2022.
//

protocol LoginInteractorInput {
    func authorize(phoneNumber: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class LoginInteractor {
    
    // MARK: - Properties
    
    private let networkService: AuthorizationNetworkServiceInput


    // MARK: - Init

    init(networkService: AuthorizationNetworkServiceInput) {
        self.networkService = networkService
    }
    
}


// MARK: - LoginInteractorInput
extension LoginInteractor: LoginInteractorInput {
    
    func authorize(phoneNumber: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        networkService.authorize(phoneNumber: phoneNumber) { result in
            
            switch result {
                
            case .success(let isSucceed):
                completion(.success(isSucceed))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
