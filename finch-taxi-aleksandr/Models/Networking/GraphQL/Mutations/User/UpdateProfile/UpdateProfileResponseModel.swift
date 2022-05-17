//
//  UpdateProfileResponseModel.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 08.04.2022.
//

struct UpdateProfileResponseModel: Decodable {
    
    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case isSucceed = "updateProfile"
    }
    
    
    // MARK: - Properties
    
    let isSucceed: Bool
}
