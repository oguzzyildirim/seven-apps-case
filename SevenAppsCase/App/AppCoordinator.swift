//
//  AppCoordinator.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 12.03.2025.
//

import RxSwift
import UIKit

class AppCoordinator: ReactiveCoordinator<Void> {
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

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
