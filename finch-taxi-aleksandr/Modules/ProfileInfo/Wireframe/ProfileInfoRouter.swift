//
//  ProfileInfoRouter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 27.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol ProfileInfoRouterInput {
    func closeModule()
}

final class ProfileInfoRouter {
    
    // MARK: - Properties
    
    private unowned let transitionHandler: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transitionHandler: ModuleTransitionHandler) {
        self.transitionHandler = transitionHandler
    }
    
}


// MARK: - ProfileInfoRouterInput
extension ProfileInfoRouter: ProfileInfoRouterInput {
    
    func closeModule() {
        transitionHandler.closeCurrentModule(animated: true)
    }
}
