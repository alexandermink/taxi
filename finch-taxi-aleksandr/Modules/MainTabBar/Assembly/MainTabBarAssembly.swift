//
//  MainTabBarAssembly.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 10.03.2022.
//

import UIKit

final class MainTabBarAssembly: Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        
        guard let model = model as? Model else {
            fatalError("Некорректная модель в модуле MainTabBarAssembly")
        }
        
        let view = UITabBarController()
        view.tabBar.tintColor = Colors.blackWhite
        view.customizeStandardAppearance()
        
        var controllers = [UIViewController]()
        
        model.items.forEach {
            let controller: UIViewController
            
            switch $0 {
                
            case .general:
                controller = ModulePlugViewController()
                controller.view.backgroundColor = Colors.whiteBlack
                
            case .myTravels:
                controller = ModulePlugViewController()
                controller.view.backgroundColor = Colors.whiteBlack
                
            case .profile:
                controller = ProfileAssembly.assembleModule(with: ProfileAssembly.Model())
            }
            
            controller.tabBarItem = .init(title: $0.title, image: $0.image)
            controllers.append(controller)
        }
        
        view.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        return view
    }
}


// MARK: - Model
extension MainTabBarAssembly {
    
    struct Model: TransitionModel {
        
        // MARK: - Properties
        
        let items: [MainTabBarItem]
        
        
        // MARK: - Init
        
        init(items: [MainTabBarItem] = [.general, .myTravels, .profile]) {
            self.items = items
        }
        
    }
    
}
