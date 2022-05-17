//
//  ProfileInfoAssembly.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 27.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

final class ProfileInfoAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Некорректная модель в модуле VerificationAssembly")
        }
        
        let services = ServiceFactory.shared
        
        let view = ProfileInfoViewController()
        let router = ProfileInfoRouter(transitionHandler: view)
        let presenter = ProfileInfoPresenter(userInfo: model.userInfo)
        let interactor = ProfileInfoInteractor(
            imageService: services.imageService,
            userDefaults: services.standardUserDefaults,
            networkService: services.profileNetworkService
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
extension ProfileInfoAssembly {
    
    struct Model: TransitionModel {
        
        // MARK: - Properties
        
        weak var moduleOutput: ProfileInfoModuleOutput?
        let userInfo: UserInfo
    }
    
}
