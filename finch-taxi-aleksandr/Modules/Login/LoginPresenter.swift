//
//  LoginPresenter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 03.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol LoginViewOutput: ViewOutput {
    
    func didTapLoginButton(phoneNumber: String)
}

final class LoginPresenter {
    
    // MARK: - Properties
    
    weak var view: LoginViewInput?
    
    var interactor: LoginInteractorInput?
    var router: LoginRouterInput?
    
    
    // MARK: - Private methods
    
    func openVerification(phoneNumber: String) {
        router?.openVerification(phoneNumber: phoneNumber, moduleOutput: self)
    }
    
}


// MARK: - LoginViewOutput
extension LoginPresenter: LoginViewOutput {
    
    func viewIsReady() {
        view?.changeKeyboardState(isActive: true)
    }
    
    func didTapLoginButton(phoneNumber: String) {
        view?.changeKeyboardState(isActive: false)
        interactor?.authorize(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
                
            case .success(let isSucceed):
                if isSucceed {
                    self?.openVerification(phoneNumber: phoneNumber)
                } else {
                    self?.view?.showAlert(title: Texts.unknownError, style: .alert)
                }
                
            case .failure(let error):
                self?.view?.showAlert(title: error.localizedDescription, style: .alert)
            }
        }
    }
}


// MARK: - VerificationModuleOutput
extension LoginPresenter: VerificationModuleOutput {
    
    func changePhoneNumber() {
        view?.updateInterface()
    }
}
