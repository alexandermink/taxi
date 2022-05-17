//
//  ProfileViewModel.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 16.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

struct ProfileViewModel {
    let rows: [Row]
}

// MARK: - ProfileViewModel
extension ProfileViewModel {
    
    enum Row {
        
        case base(TableCellConfiguratorProtocol)
        
        
        // MARK: - Properties
        
        var configurator: TableCellConfiguratorProtocol {
            
            switch self {
            case .base(let configurator):
                return configurator
            }
        }
        
        var id: String {
            type(of: configurator).id
        }
    }
}
