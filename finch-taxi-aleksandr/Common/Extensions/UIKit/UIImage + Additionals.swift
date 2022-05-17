//
//  UIImage + Additionals.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 14.03.2022.
//

import UIKit

extension UIImage {
    
    // MARK: - Public methods
    
    static func getImage(byName name: String) -> UIImage {
        .init(named: name) ??
        createRedRectangle()
    }
    
    static func getImage(bySystemName systemName: String) -> UIImage {
        .init(systemName: systemName) ??
        createRedRectangle()
    }
    
    private static func createRedRectangle() -> UIImage {
        
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContext(size)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(Colors.red.cgColor)
            context.addRect(.init(x: 0, y: 0, width: size.width, height: size.height))
            context.drawPath(using: .fill)
        }
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        }
        UIGraphicsEndImageContext()
        return UIImage()
    }
}
