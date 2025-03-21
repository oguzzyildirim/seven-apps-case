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

    override func start() -> Observable<Void> {
        let homeVC = UIStoryboard(name: "HomeVC", bundle: .main).instantiateViewController(identifier: "HomeVC")
        guard let vc = homeVC as? HomeVC else {
            print("rootViewController is not of type HomeVC")
            return Observable.never()
        }
        let httpClient = URLSession.shared
        let service = UserService(httpClient: httpClient)
        let repository = HomeRepository(userService: service)
        let vm = HomeVM(repo: repository)
        vc.viewModel = vm
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.setViewControllers([vc], animated: true)
        return Observable.never()
    }
}
