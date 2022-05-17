//
//  NetworkInterceptorProvider.swift
//  SberSound
//
//  Created by Aleksandr Konakov on 28.04.2021.
//

import Apollo

final class NetworkInterceptorProvider: LegacyInterceptorProvider {
    
    // MARK: - Properties
    
    var interceptor: CustomInterceptor {
        CoreFactory.shared.customInterceptor
    }
    
    
    // MARK: - Public methods
    
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(interceptor, at: 0)
        return interceptors
    }
    
}
