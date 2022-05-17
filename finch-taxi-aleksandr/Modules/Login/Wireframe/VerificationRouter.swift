//
//  VerificationRouter.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 04.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol VerificationRouterInput {
    func openMainScreen()
    func closeModule()
}

final class VerificationRouter {
    
    // MARK: - Properties
    
    private unowned let transitionHandler: ModuleTransitionHandler
    private let appCoordinator: AppCoordinatorInput
    
    
    // MARK: - Init
    
    init(transitionHandler: ModuleTransitionHandler, appCoordinator: AppCoordinatorInput) {
        self.transitionHandler = transitionHandler
        self.appCoordinator = appCoordinator
    }
    
}


// MARK: - VerificationRouterInput
extension VerificationRouter: VerificationRouterInput {
    
    func openMainScreen() {
        appCoordinator.showNeededFlow()
    }
    
    func closeModule() {
        transitionHandler.closeCurrentModule(animated: true)
    }
}
