//
//  UITabBarItem + CustomInit.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 14.03.2022.
//

import UIKit

extension UITabBarItem {
    
    // MARK: - Init
    
    convenience init(title: String, image: UIImage) {
        self.init(title: title, image: image, selectedImage: nil)
    }
    
}
