//
//  ProfileRouter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 16.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol ProfileRouterInput {
    func openProfileInfo(userInfo: UserInfo, moduleOutput: ProfileInfoModuleOutput)
}

final class ProfileRouter {
    
    // MARK: - Properties
    
    private unowned let transitionHandler: ModuleTransitionHandler
    
    
    // MARK: - Init
    
    init(transitionHandler: ModuleTransitionHandler) {
        self.transitionHandler = transitionHandler
    }
    
}


// MARK: - ProfileRouterInput
extension ProfileRouter: ProfileRouterInput {
    
    func openProfileInfo(userInfo: UserInfo, moduleOutput: ProfileInfoModuleOutput) {
        transitionHandler.push(
            with: ProfileInfoAssembly.Model(moduleOutput: moduleOutput, userInfo: userInfo),
            openModuleType: ProfileInfoAssembly.self
        )
    }
}
