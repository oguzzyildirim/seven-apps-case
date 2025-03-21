//
//  HomeCoordinator.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 15.03.2025.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

final class HomeCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private var navigationController: UINavigationController

    init(rootViewController: UIViewController, navigationController: UINavigationController) {
        self.rootViewController = rootViewController
        self.navigationController = navigationController
    }

    /// Starts the Home screen flow with proper dependency injection
    ///
    /// This method:
    /// 1. Instantiates the HomeVC from storyboard
    /// 2. Creates and injects all dependencies (HTTPClient, UserService, Repository, ViewModel)
    /// 3. Configures the navigation controller
    ///
    /// The implementation follows the dependency injection pattern where each layer
    /// receives its dependencies through constructor injection.
    ///
    /// - Returns: An observable that never completes as this is a main application flow
    override func start() -> Observable<Void> {
        let homeVC = UIStoryboard(name: "HomeVC", bundle: .main).instantiateViewController(identifier: "HomeVC")
        guard let vc = homeVC as? HomeVC else {
            print("rootViewController is not of type HomeVC")
            return Observable.never()
        }
        // Dependency injection chain:
        let httpClient = URLSession.shared
        let service = UserService(httpClient: httpClient)
        let repository = HomeRepository(userService: service)
        let vm = HomeVM(repo: repository)
        vc.viewModel = vm
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController.setNavigationBarHidden(true, animated: true)
            self.navigationController.setViewControllers([vc], animated: true)
           
        }
        return Observable.never()
    }
}
