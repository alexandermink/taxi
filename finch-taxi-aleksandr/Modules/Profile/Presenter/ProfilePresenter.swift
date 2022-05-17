//
//  ProfilePresenter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 16.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol ProfileViewOutput: ViewOutput {  }

final class ProfilePresenter {
    
    // MARK: - Properties
    
    weak var view: ProfileViewInput?
    
    var interactor: ProfileInteractorInput?
    var router: ProfileRouterInput?
    
    private var items: [ProfileItem]
    private var userInfo: UserInfo? {
        didSet {
            for (index, value) in items.enumerated() {
                if case .profile = value {
                    let key = userInfo?.imageKey
                    let avatarImage = key != nil ? interactor?.getImage(forKey: key ?? "") : nil
                    items[index] = .profile(userInfo, avatarImage: avatarImage)
                    view?.update(with: dataConverter.convert(items: items))
                    break
                }
            }
        }
    }
    
    private let dataConverter: ProfileDataConverterInput
    
    
    // MARK: - Init
    
    init(items: [ProfileItem],
         dataConverter: ProfileDataConverterInput) {
        
        self.items = items
        self.dataConverter = dataConverter
    }
}


// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    
    func viewIsReady() {
        view?.update(with: dataConverter.convert(items: items))
        interactor?.getUserInfo { [weak self] userInfo in
            self?.userInfo = userInfo
        }
    }
}


// MARK: - ProfileTableViewManagerDelegate
extension ProfilePresenter: ProfileTableViewManagerDelegate {
    
    func didSelectItem(by index: Int) {
        
        switch items[index] {
        case .myInfo:
            if let userInfo = userInfo {
                router?.openProfileInfo(userInfo: userInfo, moduleOutput: self)
            }
            
        case .logout:
            if let userInfo = userInfo {
                interactor?.logout(userInfo: userInfo) { [weak self] error in
                    self?.view?.showAlert(title: error.localizedDescription, style: .alert)
                }
            }
            
        case .profile,
             .rules,
             .faq,
             .settings:
            
            return
        }
    }
    
}


// MARK: - ProfileInfoModuleOutput
extension ProfilePresenter: ProfileInfoModuleOutput {
    
    func changeUserInfo(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
}
