//
//  ProfileInfoPresenter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 27.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol ProfileInfoViewOutput: ViewOutput {
    func didTapSaveButton(surname: String?, name: String?, imageInfo: (image: UIImage, name: String)?)
    func didTapCancelButton()
}

final class ProfileInfoPresenter {
    
    // MARK: - Properties
    
    weak var view: ProfileInfoViewInput?
    weak var moduleOutput: ProfileInfoModuleOutput?
    
    var interactor: ProfileInfoInteractorInput?
    var router: ProfileInfoRouterInput?
    
    private var userInfo: UserInfo
    private var editedUserInfo: UserInfo
    
    
    // MARK: - Init
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
        self.editedUserInfo = userInfo
    }
    
}


// MARK: - MyInfoViewOutput
extension ProfileInfoPresenter: ProfileInfoViewOutput {
    
    func viewIsReady() {
        
        view?.updateUserInfo(userInfo: userInfo)
        if let key = userInfo.imageKey, let image = interactor?.getImage(forKey: key) {
            view?.updateAvatarImage(info: (image: image, name: key))
        }
    }
    
    func didTapSaveButton(surname: String?, name: String?, imageInfo: (image: UIImage, name: String)?) {
        
        view?.updateUIState(isEnabled: false)
        
        editedUserInfo.surname = surname
        editedUserInfo.name = name
        
        if let info = imageInfo {
            if editedUserInfo.imageKey != info.name {
                interactor?.saveImage(info.image, forKey: info.name) { [weak self] error in
                    self?.view?.showAlert(title: error.localizedDescription, style: .alert)
                }
                editedUserInfo.imageKey = info.name
            }
        } else {
            if let key = editedUserInfo.imageKey {
                interactor?.deleteImage(forKey: key) { [weak self] error in
                    self?.view?.showAlert(title: error.localizedDescription, style: .alert)
                }
            }
            editedUserInfo.imageKey = nil
        }
        
        guard userInfo != editedUserInfo else {
            router?.closeModule()
            return
        }
        
        interactor?.saveUserInfo(editedUserInfo) { [weak self, editedUserInfo] response in
            
            switch response {
                
            case .success(let isSucceed):
                if isSucceed {
                    self?.moduleOutput?.changeUserInfo(userInfo: editedUserInfo)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self?.view?.updateUIState(isEnabled: true)
                        self?.router?.closeModule()
                    }
                } else {
                    self?.view?.showAlert(
                        title: Texts.unknownError,
                        style: .alert,
                        actions: [
                            .init(title: Texts.ok) {
                                self?.view?.updateUIState(isEnabled: true)
                            }
                        ]
                    )
                }
                
            case .failure(let error):
                self?.view?.showAlert(
                    title: error.localizedDescription,
                    style: .alert,
                    actions: [
                        .init(title: Texts.ok) {
                            self?.view?.updateUIState(isEnabled: true)
                        }
                    ]
                )
            }
        }
    }
    
    func didTapCancelButton() {
        router?.closeModule()
    }
    
}
