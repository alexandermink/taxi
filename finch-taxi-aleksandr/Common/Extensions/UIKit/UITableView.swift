//
//  UITableView.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 18.02.2022.
//

import UIKit

extension UITableView {
    
    // MARK: - Public methods
    
    func register(_ cellTypes: UITableViewCell.Type...) {
        
        cellTypes.forEach {
            register($0, forCellReuseIdentifier: String(describing: $0) )
        }
        
    }
}
