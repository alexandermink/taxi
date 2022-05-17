//
//  UserMutationResponseModel.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 30.03.2022.
//

struct UserMutationResponseModel<ResponseModel: Decodable>: Decodable {

    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case response = "UserMutation"
    }
    
    
    // MARK: - Properties
    
    let response: ResponseModel
}
