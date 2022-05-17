//
//  UINavigationController + Customization.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 16.03.2022.
//

import UIKit

extension UINavigationController {
    
    // MARK: - Public methods
    
    func customizeStandardAppearance(with model: AppearanceModel = .init()) {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = model.backgroundColor
        appearance.shadowColor = model.shadowColor
        appearance.shadowImage = model.shadowImage
        navigationBar.tintColor = model.tintColor
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        if #available(iOS 15.0, *) {
            navigationBar.compactScrollEdgeAppearance = appearance
        }
    }
}


// MARK: - AppearanceModel
extension UINavigationController {
    
    struct AppearanceModel {
        
        // MARK: - Properties
        
        let backgroundColor: UIColor?
        let shadowColor: UIColor?
        let shadowImage: UIImage?
        let tintColor: UIColor?
        
        
        // MARK: - Init
        
        init(backgroundColor: UIColor? = Colors.whiteBlack,
             shadowColor: UIColor? = nil,
             shadowImage: UIImage? = nil,
             tintColor: UIColor? = Colors.blackWhite) {
            
            self.backgroundColor = backgroundColor
            self.shadowColor = shadowColor
            self.shadowImage = shadowImage
            self.tintColor = tintColor
        }
    }
}
