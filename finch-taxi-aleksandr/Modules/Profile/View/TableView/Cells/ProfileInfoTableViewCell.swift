//
//  ProfileInfoTableViewCell.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 17.02.2022.
//

import UIKit

typealias ProfileTableViewCellConfigurator = TableCellConfigurator<ProfileInfoTableViewCell, ProfileInfoTableViewCell.Model>

class ProfileInfoTableViewCell: NLTableViewCell {
    
    // MARK: - Locals
    
    private enum Locals {
        static let avatarImageViewHeight: CGFloat = 60
    }
    
    
    // MARK: - Properties
    
    let fullnameContainer = UIStackView()
    let surnameLabel = UILabel()
    let nameLabel = UILabel()
    let phoneNumberLabel = UILabel()
    let avatarImageView = UIImageView()
    
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        selectionStyle = .none
        
        backgroundColor = Colors.whiteBlack
        
        surnameLabel.font = Fonts.systemBold40
        surnameLabel.textColor = Colors.blackWhite
        
        nameLabel.font = Fonts.systemBold40
        nameLabel.textColor = Colors.blackWhite
        
        fullnameContainer.axis = .vertical
        fullnameContainer.addArrangedSubview(surnameLabel)
        fullnameContainer.addArrangedSubview(nameLabel)
        contentView.addSubview(fullnameContainer)
        
        phoneNumberLabel.font = Fonts.system16
        phoneNumberLabel.textColor = Colors.lightGray
        contentView.addSubview(phoneNumberLabel)
        
        avatarImageView.clipsToBounds = true
        avatarImageView.tintColor = Colors.darkGray
        avatarImageView.layer.cornerRadius = Locals.avatarImageViewHeight / 2
        avatarImageView.layer.borderColor = Colors.darkGray.cgColor
        avatarImageView.layer.borderWidth = 2
        contentView.addSubview(avatarImageView)
        
        [fullnameContainer, surnameLabel, nameLabel, phoneNumberLabel, avatarImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            fullnameContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            fullnameContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            fullnameContainer.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -8),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: fullnameContainer.bottomAnchor, constant: 16),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            avatarImageView.centerYAnchor.constraint(equalTo: fullnameContainer.centerYAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            avatarImageView.widthAnchor.constraint(equalToConstant: Locals.avatarImageViewHeight),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
}


// MARK: - Configurable
extension ProfileInfoTableViewCell: Configurable {
    
    func configure(with model: Model) {
        
        surnameLabel.text = model.surname?.isEmpty ?? true ? Texts.surname : model.surname
        nameLabel.text = model.name?.isEmpty ?? true ? Texts.name : model.name
        phoneNumberLabel.text = model.phoneNumber ?? Texts.phoneNumber
        avatarImageView.image = model.avatarImage ?? Images.System.personCropCircle
    }
    
}


// MARK: - Model
extension ProfileInfoTableViewCell {
    
    struct Model {
        
        // MARK: - Properties
        
        let surname: String?
        let name: String?
        let phoneNumber: String?
        let avatarImage: UIImage?
        
        
        // MARK: - Init
        
        init(surname: String?,
             name: String?,
             phoneNumber: String?,
             avatarImage: UIImage?) {
            
            self.surname = surname
            self.name = name
            self.phoneNumber = phoneNumber
            self.avatarImage = avatarImage
        }
    }
}

