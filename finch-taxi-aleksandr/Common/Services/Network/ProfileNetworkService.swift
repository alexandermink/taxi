//
//  ProfileNetworkService.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 22.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol ProfileNetworkServiceInput {
    func getUserInfo(completion: @escaping (UserInfo) -> Void)
    func updateProfile(userInfo: UserInfo?, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class ProfileNetworkService {
    
    // MARK: - Properties
    
    private let graphQLClient: GraphQLClientInput
    
    
    // MARK: - Init
    
    init(graphQLClient: GraphQLClientInput) {
        self.graphQLClient = graphQLClient
    }
    
}


// MARK: - ProfileNetworkServiceInput
extension ProfileNetworkService: ProfileNetworkServiceInput {
    
    func getUserInfo(completion: @escaping (UserInfo) -> Void) {
        
        graphQLClient.fetch(query: ProfileRequestQuery()) {
            (result: Result<UserQueryResponseModel<GetProfileResponseModel>, GraphQLError>) in
            
            switch result {
                
            case .success(let response):
                completion(.init(byNetworkModel: response.response.getProfile))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateProfile(userInfo: UserInfo?, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        graphQLClient.mutate(mutation: ProfileInfoRequestMutation(profile: .init(name: userInfo?.name,
                                                                                 surname: userInfo?.surname))) {
            (result: Result<UserMutationResponseModel<UpdateProfileResponseModel>, GraphQLError>) in
            
            switch result {
                
            case .success(let response):
                completion(.success(response.response.isSucceed))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
