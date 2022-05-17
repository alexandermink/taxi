//
//  ProfileInfoInteractor.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 01.03.2022.
//

import UIKit

protocol ProfileInfoInteractorInput {
    func getImage(forKey key: String) -> UIImage?
    func saveImage(_ image: UIImage, forKey key: String, completion: @escaping (Error) -> Void)
    func deleteImage(forKey key: String, completion: @escaping (Error) -> Void)
    func saveUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class ProfileInfoInteractor {
    
    // MARK: - Properties
    
    private let imageService: ImageServiceInput
    private let userDefaults: UserDefaults
    private let networkService: ProfileNetworkServiceInput
    
    
    // MARK: - Init
    
    init(imageService: ImageServiceInput,
         userDefaults: UserDefaults,
         networkService: ProfileNetworkServiceInput) {
        
        self.imageService = imageService
        self.userDefaults = userDefaults
        self.networkService = networkService
    }
}


// MARK: - ProfileInfoInteractorInput
extension ProfileInfoInteractor: ProfileInfoInteractorInput {
    
    func getImage(forKey key: String) -> UIImage? {
        imageService.getImage(forKey: key)
    }
    
    func saveImage(_ image: UIImage, forKey key: String, completion: @escaping (Error) -> Void){
        imageService.saveImage(image, forKey: key, completion: completion)
    }
    
    func deleteImage(forKey key: String, completion: @escaping (Error) -> Void) {
        imageService.deleteImage(forKey: key, completion: completion)
    }
    
    func saveUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        networkService.updateProfile(userInfo: userInfo) { [weak self] response in
            
            switch response {
                
            case .success(let isSucceed):
                self?.userDefaults.userInfo = userInfo
                completion(.success(isSucceed))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
