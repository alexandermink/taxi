//
//  VerificationPresenter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 04.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol VerificationViewOutput: ViewOutput {
    func didTapChangePhoneNumber()
    func didEnterSMSCode(_ smsCode: String)
}

final class VerificationPresenter {
    
    // MARK: - Properties
    
    weak var view: VerificationViewInput?
    weak var moduleOutput: VerificationModuleOutput?
    
    var interactor: VerificationInteractorInput?
    var router: VerificationRouterInput?
    
    private let phoneNumber: String
    
    
    // MARK: - Init
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}


// MARK: - VerificationViewOutput
extension VerificationPresenter: VerificationViewOutput {
    
    func viewIsReady() {
        view?.updateInterface(phoneNumber: phoneNumber)
    }
    
    func didTapChangePhoneNumber() {
        
        view?.changeKeyboardState(isActive: false)
        moduleOutput?.changePhoneNumber()
        router?.closeModule()
    }
    
    func didEnterSMSCode(_ smsCode: String) {
        
        view?.updateUIState(isEnabled: false)
        interactor?.authorize(phoneNumber: phoneNumber, smsCode: smsCode) { [weak self] result in
            self?.view?.updateUIState(isEnabled: true)
            
            switch result {
                
            case .success(let isAuthorized):
                if isAuthorized {
                    self?.router?.openMainScreen()
                }
                
            case .failure(let error):
                self?.view?.showAlert(
                    title: error.localizedDescription,
                    style: .alert,
                    actions: [
                        .init(title: Texts.ok) {
                            self?.view?.startEnterSMSCode()
                        }
                    ]
                )
            }
        }
    }
    
}
