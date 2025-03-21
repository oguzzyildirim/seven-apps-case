//
//  UserDetailCoordinator.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

final class UserDetailCoordinator: ReactiveCoordinator<Void> {
    private let rootViewController: UIViewController
    private let user: User?

    init(rootViewController: UIViewController, user: User?) {
        self.rootViewController = rootViewController
        self.user = user
    }

    override func start() -> Observable<Void> {
        let userDetailVC = UserDetailVC()
        let userDetailVM = UserDetailVM(user: user)

        userDetailVC.viewModel = userDetailVM
        rootViewController.navigationController?.pushViewController(userDetailVC, animated: true)
        return Observable.never()
    }
}
