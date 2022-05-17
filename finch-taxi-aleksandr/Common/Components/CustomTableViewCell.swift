//
//  CustomTableViewCell.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 17.02.2022.
//

import UIKit

typealias CustomTableViewCellConfigurator = TableCellConfigurator<CustomTableViewCell, CustomTableViewCell.Model>

final class CustomTableViewCell: NLTableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    private let rightArrowImageView = UIImageView()
    
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        selectionStyle = .none
        
        backgroundColor = Colors.whiteBlack
        
        titleLabel.font = Fonts.system18
        titleLabel.textColor = Colors.blackWhite
        
        separatorView.backgroundColor = Colors.lightGray
        
        rightArrowImageView.image = Images.rightArrow
        
        [titleLabel, separatorView, rightArrowImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: rightArrowImageView.leadingAnchor, constant: -16),
            
            rightArrowImageView.heightAnchor.constraint(equalToConstant: 14),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: 10),
            rightArrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightArrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
}


// MARK: - Configurable
extension CustomTableViewCell: Configurable {
    
    func configure(with model: Model) {
        titleLabel.text = model.title
        titleLabel.font = model.titleFont
        separatorView.isHidden = model.isSeparatorHidden
        rightArrowImageView.isHidden = model.isRightArrowHidden
    }
}


// MARK: - Model
extension CustomTableViewCell {
    
    struct Model {
        
        // MARK: - Properties
        
        let title: String
        let titleFont: UIFont
        let isSeparatorHidden: Bool
        let isRightArrowHidden: Bool
        
        
        // MARK: - Init
        
        init(title: String,
             titleFont: UIFont = Fonts.system16,
             isSeparatorHidden: Bool = false,
             isRightArrowHidden: Bool = false) {
            
            self.title = title
            self.titleFont = titleFont
            self.isSeparatorHidden = isSeparatorHidden
            self.isRightArrowHidden = isRightArrowHidden
        }
    }
}
