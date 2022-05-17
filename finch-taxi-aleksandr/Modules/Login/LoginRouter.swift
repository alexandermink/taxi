//
//  LoginRouter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 03.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol LoginRouterInput {
    func openVerification(phoneNumber: String, moduleOutput: VerificationModuleOutput)
}

final class LoginRouter {
    
    // MARK: - Properties
    
    private unowned let transitionHandler: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transitionHandler: ModuleTransitionHandler) {
        self.transitionHandler = transitionHandler
    }
    
}


// MARK: - LoginRouterInput
extension LoginRouter: LoginRouterInput {
    
    func openVerification(phoneNumber: String, moduleOutput: VerificationModuleOutput) {
        let model = VerificationAssembly.Model(moduleOutput: moduleOutput, phoneNumber: phoneNumber)
        transitionHandler.push(with: model, openModuleType: VerificationAssembly.self)
    }
    
}
