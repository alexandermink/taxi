//
//  UIColor + HEX.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 11.02.2022.
//

import UIKit

extension UIColor {

    convenience init(rgb: Int, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: alpha
        )
    }
    
}
