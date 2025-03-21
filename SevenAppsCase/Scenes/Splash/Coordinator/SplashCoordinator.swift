//
//  SplashCoordinator.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 12.03.2025.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

final class SplashCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private var navigationController: UINavigationController
    private let vm = SplashVM()

    init(rootViewController: UIViewController, navigationController: UINavigationController) {
        self.rootViewController = rootViewController
        self.navigationController = navigationController
    }

    override func start() -> Observable<Void> {
        guard let vc = rootViewController as? SplashVC else {
            print("rootViewController is not of type SplashVC")
            return Observable.never()
        }
        vc.viewModel = vm
        let coordinator = HomeCoordinator(rootViewController: rootViewController,
                                          navigationController: navigationController)
        return coordinate(to: coordinator)
    }
}
