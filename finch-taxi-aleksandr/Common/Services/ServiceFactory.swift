//
//  ServiceFactory.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 15.03.2022.
//

import Foundation
import UIKit

final class ServiceFactory {
    
    // MARK: - Properties
    
    static let shared = ServiceFactory()
    
    
    // MARK: - Storages
    
    var standardUserDefaults: UserDefaults {
        .standard
    }

    var defaultFileManager: FileManager {
        .default
    }
    
    var keychainWrapper: KeychainWrapper {
        .init()
    }
    
    
    // MARK: - Services
    
    var imageService: ImageService {
        .init(fileManager: defaultFileManager)
    }
    
    
    // MARK: - NetworkServices
    
    var profileNetworkService: ProfileNetworkServiceInput {
        ProfileNetworkService(graphQLClient: graphQLClient)
    }
    
    var graphQLClient: GraphQLClientInput {
        GraphQLClient()
    }
    
    var authorizationNetworkService: AuthorizationNetworkServiceInput {
        AuthorizationNetworkService(graphQLClient: graphQLClient)
    }
    
    
    // MARK: - Init
    
    private init() {  }
    
}


// MARK: - NSCopying
extension ServiceFactory: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        self
    }
}
