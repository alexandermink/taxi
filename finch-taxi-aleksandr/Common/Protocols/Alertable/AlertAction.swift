//
//  AlertAction.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 23.03.2022.
//

import UIKit

struct AlertAction {
    
    // MARK: - Properties
    
    static let ok = AlertAction(title: Texts.ok)
    
    let title: String
    let titleColor: UIColor
    let style: UIAlertAction.Style
    let action: (() -> Void)?
    
    
    // MARK: - Init
    
    init(title: String,
         titleColor: UIColor = Colors.blackWhite,
         style: UIAlertAction.Style = .default,
         action: (() -> Void)? = nil) {
        
        self.title = title
        self.titleColor = titleColor
        self.style = style
        self.action = action
    }
}
