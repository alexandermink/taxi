//
//  SendCodeResponseModel.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 01.04.2022.
//

struct SendCodeResponseModel: Decodable {
    
    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case isSucceed = "sendCode"
    }
    
    
    // MARK: - Properties
    
    let isSucceed: Bool
}
