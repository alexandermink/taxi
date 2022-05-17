//
//  MainTabBarItem.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 10.03.2022.
//

import UIKit

enum MainTabBarItem {
    
    case general
    case myTravels
    case profile
    
    
    // MARK: - Properties
    
    var title: String {
        
        switch self {
            
        case .general:
            return "Главная"
            
        case .myTravels:
            return "Мои поездки"
            
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage {
        
        switch self {
            
        case .general:
            return Images.MainTabBarIcons.general
            
        case .myTravels:
            return Images.MainTabBarIcons.myTravels
            
        case .profile:
            return Images.MainTabBarIcons.profile
        }
    }
}
