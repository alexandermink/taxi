//
//  VerificationAssembly.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 04.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

final class VerificationAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Некорректная модель в модуле VerificationAssembly")
        }
        
        let services = ServiceFactory.shared
        let managers = ManagerFactory.shared
        
        let view = VerificationViewController()
        let router = VerificationRouter(transitionHandler: view, appCoordinator: managers.appCoordinator)
        let presenter = VerificationPresenter(phoneNumber: model.phoneNumber)
        let interactor = VerificationInteractor(
            networkService: services.authorizationNetworkService,
            authorizationManager: managers.authorizationManager
        )
        
        view.presenter = presenter
        view.keyboardHandler = KeyboardHandler(delegate: view)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.moduleOutput = model.moduleOutput
        
        return view
    }

}


// MARK: - Model
extension VerificationAssembly {
    
    struct Model: TransitionModel {
        
        // MARK: - Properties
        
        weak var moduleOutput: VerificationModuleOutput?
        var phoneNumber: String
        
    }
    
}
