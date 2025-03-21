//
//  AppCoordinator.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 12.03.2025.
//

import RxSwift
import UIKit

/// Main coordinator for the application that manages the app's navigation flow
///
/// The AppCoordinator is responsible for initializing the application window,
/// setting up the initial screen, and coordinating transitions between major application flows.
/// It serves as the root coordinator in the coordinator pattern hierarchy.
class AppCoordinator: ReactiveCoordinator<Void> {
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    /// Starts the application flow by setting up the initial screen
    ///
    /// This method:
    /// 1. Creates the splash screen controller
    /// 2. Configures a navigation controller with the splash screen
    /// 3. Sets up the navigation appearance
    /// 4. Configures the window with the navigation controller as its root
    /// 5. Coordinates to the splash flow
    ///
    /// - Returns: An observable that completes when the app coordinator flow finishes
    override func start() -> Observable<Void> {
        let splashController = SplashVC()
        let navigationController = UINavigationController(rootViewController: splashController)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.navigationBar.isTranslucent = false
        navigationController.view.backgroundColor = splashController.view.backgroundColor
        
        let splashCoordinator = SplashCoordinator(rootViewController: splashController, navigationController: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return coordinate(to: splashCoordinator)
    }
}
