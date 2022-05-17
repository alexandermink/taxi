//
//  ProfileAssembly.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 16.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

final class ProfileAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Некорректная модель в модуле ProfileAssembly")
        }
        
        let services = ServiceFactory.shared
        let managers = ManagerFactory.shared
        let tableViewManager = ProfileTableViewManager()
        
        let view = ProfileViewController()
        let router = ProfileRouter(transitionHandler: view)
        let presenter = ProfilePresenter(
            items: model.items,
            dataConverter: ProfileDataConverter()
        )
        
        let interactor = ProfileInteractor(
            networkService: services.profileNetworkService,
            imageService: services.imageService,
            userDefaults: services.standardUserDefaults,
            authorizationManager: managers.authorizationManager
        )
        
        tableViewManager.delegate = presenter
        
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }

}


// MARK: - Model
extension ProfileAssembly {
    
    struct Model: TransitionModel {
        
        // MARK: - Properties
        
        let items: [ProfileItem]
        
        
        // MARK: - Init
        
        init(items: [ProfileItem] = [.profile(), .myInfo, .rules, .faq, .settings, .logout]) {
            self.items = items
        }
    }
    
}
