//
//  UserDefaults + Properties.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 04.03.2022.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Types
    
    private enum Keys {
        static let userInfo = "userInfoKey"
        static let isAppRunBefore = "isAppRunBefore"
    }
    
    
    // MARK: - Properties
    
    var userInfo: UserInfo? {
        get {
            if let data = object(forKey: Keys.userInfo) as? Data,
               let value = try? PropertyListDecoder().decode(UserInfo.self, from: data) {
                
                return value
            } else {
                return nil
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                set(data, forKey: Keys.userInfo)
            } else if newValue == nil {
                set(newValue, forKey: Keys.userInfo)
            }
        }
    }
    
    var isAppRunBefore: Bool {
        get {
            bool(forKey: Keys.isAppRunBefore)
        }
        set {
            set(newValue, forKey: Keys.isAppRunBefore)
        }
    }
}
