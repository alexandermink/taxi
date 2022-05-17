//
//  ProfileItem.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 16.02.2022.
//

import UIKit

enum ProfileItem {
    
    case profile(UserInfo? = nil, avatarImage: UIImage? = nil)
    case myInfo
    case rules
    case faq
    case settings
    case logout
    
    
    // MARK: - Properties
    
    var title: String? {
        
        switch self {
        case .myInfo:
            return "Мои данные"
            
        case .rules:
            return "Правила"
            
        case .faq:
            return "FAQ"
            
        case .settings:
            return "Настройки"
            
        case .logout:
            return "Выйти"
            
        case .profile:
            return nil
        }
    }
    
    var titleFont: UIFont? {
        
        switch self {
        case .myInfo,
             .rules,
             .faq,
             .settings:
            
            return Fonts.system18
            
        case .logout:
            return Fonts.systemMedium18
            
        case .profile:
            return nil
        }
    }
    
    var isRightArrowHidden: Bool? {
        
        switch self {
        case .myInfo,
             .rules,
             .faq,
             .settings:
            
            return false
            
        case .logout:
            return true
            
        case .profile:
            return nil
        }
    }
    
    var isSeparatorHidden: Bool? {
        
        switch self {
        case .myInfo,
             .rules,
             .faq,
             .settings:
            
            return false
            
        case .logout:
            return true
            
        case .profile:
            return nil
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .profile:
            return 200
            
        case .myInfo,
             .rules,
             .faq,
             .settings:
            
            return 64
            
        case .logout:
            return 144
        }
    }
}
