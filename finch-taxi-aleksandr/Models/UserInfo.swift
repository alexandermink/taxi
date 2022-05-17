//
//  UserInfo.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 16.02.2022.
//

struct UserInfo: Codable {
    
    // MARK: - Properties
    
    var surname: String?
    var name: String?
    let phoneNumber: String
    var imageKey: String?
    
    
    // MARK: - Init
    
    init(byNetworkModel model: GetProfileModel) {
        self.surname = model.user.surname == model.phone ? nil : model.user.surname
        self.name = model.user.name == model.phone ? nil : model.user.name
        self.phoneNumber = model.phone
    }
    
}

// MARK: - Equatable
extension UserInfo: Equatable {
    
    static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        
        lhs.name == rhs.name &&
        lhs.surname == rhs.surname &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.imageKey == rhs.imageKey
    }
    
}
