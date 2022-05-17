//
//  KeychainWrapper + Properties.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 21.03.2022.
//

import KeychainSwift

typealias KeychainWrapper = KeychainSwift

extension KeychainWrapper {
    
    // MARK: - Types
    
    private enum Keys {
        static let authorizationToken = "authorizationToken"
    }
    
    
    // MARK: - Properties
    
    var authorizationToken: String? {
        
        get {
            get(Keys.authorizationToken)
        }
        set {
            guard let value = newValue else {
                delete(Keys.authorizationToken)
                return
            }
            set(value, forKey: Keys.authorizationToken)
            
        }
    }
    
}
