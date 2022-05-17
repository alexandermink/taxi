//
//  LoginAssembly.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 03.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

final class LoginAssembly: Assembly {
    
    static func assembleModule() -> Module {
        
        let services = ServiceFactory.shared
        
        let view = LoginViewController()
        let router = LoginRouter(transitionHandler: view)
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(networkService: services.authorizationNetworkService)
        
        view.presenter = presenter
        view.keyboardHandler = KeyboardHandler(delegate: view)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }

}
