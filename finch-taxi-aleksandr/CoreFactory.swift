//
//  CoreFactory.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 29.03.2022.
//

import Foundation

final class CoreFactory {
    
    // MARK: - Properties
    
    static let shared = CoreFactory()
    
    var customInterceptor: CustomInterceptor {
        .init(keychainWrapper: services.keychainWrapper)
    }
    
    private let services = ServiceFactory.shared
    
    
    // MARK: - Init
    
    private init() {  }
}


// MARK: - NSCopying
extension CoreFactory: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        self
    }
}
