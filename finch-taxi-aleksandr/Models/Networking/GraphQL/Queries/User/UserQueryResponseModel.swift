//
//  UserQueryResponseModel.swift
//  finch-taxi-aleksandr (release)
//
//  Created by Александр Минк on 06.04.2022.
//

struct UserQueryResponseModel<ResponseModel: Decodable>: Decodable {

    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case response = "UserQuery"
    }
    
    
    // MARK: - Properties
    
    let response: ResponseModel
}
