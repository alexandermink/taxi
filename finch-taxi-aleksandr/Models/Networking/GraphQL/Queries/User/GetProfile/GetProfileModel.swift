//
//  GetProfileModel.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 06.04.2022.
//

struct GetProfileModel: Decodable {
    
    // MARK: - Properties
    
    let phone: String
    let user: UserProfileModel
}
