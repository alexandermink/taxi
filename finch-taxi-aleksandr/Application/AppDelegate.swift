//
//  AppDelegate.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 02.02.2022.
//

import UIKit

#if DEBUG
import CocoaDebug
#endif

@main
final class AppDelegate: UIResponder {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    private lazy var coordinator: AppCoordinatorInput = {
        ManagerFactory.shared.appCoordinator
    }()
    
    private lazy var authorizationManager: AuthorizationManagerInput = {
        ManagerFactory.shared.authorizationManager
    }()
    
    
    // MARK: - Private methods
    
    private func startFlow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        coordinator.startFlow(onWindow: window)
        window.makeKeyAndVisible()
        self.window = window
    }
    
}


// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        #if DEBUG
        CocoaDebugSettings.shared.enableLogMonitoring = true
        #endif
        
        authorizationManager.clearAuthorizationToken()
        startFlow()
        return true
    }
}
