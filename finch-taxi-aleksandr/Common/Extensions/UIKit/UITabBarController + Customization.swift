//
//  UITabBarController + Customization.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 15.03.2022.
//

import UIKit

extension UITabBarController {
    
    // MARK: - Public methods
    
    func customizeStandardAppearance(with model: AppearanceModel = .init()) {
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = model.backgroundColor
        appearance.shadowColor = model.shadowColor
        appearance.shadowImage = model.shadowImage
        tabBar.standardAppearance = appearance
    }
}


// MARK: - AppearanceModel
extension UITabBarController {
    
    struct AppearanceModel {
        
        // MARK: - Properties
        
        let backgroundColor: UIColor?
        let shadowColor: UIColor?
        let shadowImage: UIImage?
        
        
        // MARK: - Init
        
        init(backgroundColor: UIColor? = Colors.whiteBlack,
             shadowColor: UIColor? = nil,
             shadowImage: UIImage? = nil) {
            
            self.backgroundColor = backgroundColor
            self.shadowColor = shadowColor
            self.shadowImage = shadowImage
        }
    }
}
