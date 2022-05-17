//
//  NLTableViewCell.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 17.02.2022.
//

import UIKit

class NLTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable, message: "")
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
