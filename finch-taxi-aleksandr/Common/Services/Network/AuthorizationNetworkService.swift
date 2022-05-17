//
//  AuthorizationNetworkService.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 04.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol AuthorizationNetworkServiceInput {
    func authorize(phoneNumber: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func authorize(phoneNumber: String,
                   smsCode: String,
                   completion: @escaping (Result<String, Error>) -> Void)
}

final class AuthorizationNetworkService {
    
    // MARK: - Properties
    
    private let graphQLClient: GraphQLClientInput
    
    
    // MARK: - Init
    
    init(graphQLClient: GraphQLClientInput) {
        self.graphQLClient = graphQLClient
    }
    
}


// MARK: - AuthorizationNetworkServiceInput
extension AuthorizationNetworkService: AuthorizationNetworkServiceInput {
    
    func authorize(phoneNumber: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        graphQLClient.mutate(mutation: LoginRequestMutation(phone: phoneNumber)) {
            (result: Result<UserMutationResponseModel<SendCodeResponseModel>, GraphQLError>) in
            
            switch result {
                
            case .success(let response):
                completion(.success(response.response.isSucceed))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func authorize(phoneNumber: String,
                   smsCode: String,
                   completion: @escaping (Result<String, Error>) -> Void) {
        
        graphQLClient.mutate(mutation: VerificationRequestMutation(phone: phoneNumber, code: smsCode)) {
            (result: Result<UserMutationResponseModel<ConfirmCodeResponseModel>, GraphQLError>) in
            
            switch result {
                
            case .success(let response):
                completion(.success(response.response.confirmCode.token))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
