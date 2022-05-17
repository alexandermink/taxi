//
//  ProfileDataConverter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 16.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol ProfileDataConverterInput {
    func convert(items: [ProfileItem]) -> ProfileViewModel
}

final class ProfileDataConverter {
    
    // MARK: - Types
    
    typealias Row = ProfileViewModel.Row
    
    
    // MARK: - Private methods
    
    private func createRow(item: ProfileItem) -> Row {
        
        let configurator: TableCellConfiguratorProtocol
        
        switch item {
        case let .profile(userInfo, image):
            configurator = ProfileTableViewCellConfigurator(
                model: ProfileInfoTableViewCell.Model(
                    surname: userInfo?.surname,
                    name: userInfo?.name,
                    phoneNumber: userInfo?.phoneNumber,
                    avatarImage: image
                ),
                cellHeight: item.cellHeight
            )
            
        case .myInfo, .rules, .faq, .settings, .logout:
            configurator = CustomTableViewCellConfigurator(
                model: CustomTableViewCell.Model(
                    title: item.title ?? "",
                    titleFont: item.titleFont ?? Fonts.system16,
                    isSeparatorHidden: item.isSeparatorHidden ?? false,
                    isRightArrowHidden: item.isRightArrowHidden ?? false
                ),
                cellHeight: item.cellHeight
            )
        }
        
        return .base(configurator)
    }
}


// MARK: - ProfileDataConverterInput
extension ProfileDataConverter: ProfileDataConverterInput {
    
    func convert(items: [ProfileItem]) -> ProfileViewModel {
        ProfileViewModel(rows: items.map { createRow(item: $0) })
    }
}
