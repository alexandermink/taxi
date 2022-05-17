//
//  CustomInterceptor.swift
//  SberSound
//
//  Created by Aleksandr Konakov on 28.04.2021.
//

import Apollo

final class CustomInterceptor: ApolloInterceptor {
    
    // MARK: - Properties
    
    private let keychainWrapper: KeychainWrapper
    
    
    // MARK: - Init
    
    init(keychainWrapper: KeychainWrapper) {
        self.keychainWrapper = keychainWrapper
    }
    
    
    // MARK: - Public methods
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        
        if let token = keychainWrapper.authorizationToken {
            request.addHeader(name: "Authorization", value: token)
        }
        
        chain.proceedAsync(request: request, response: response, completion: completion)
    }
    
}
