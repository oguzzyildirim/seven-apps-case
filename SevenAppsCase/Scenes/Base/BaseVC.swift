//
//  BaseVC.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 12.03.2025.
//

import RxSwift
import Combine
import UIKit

/// Base view controller that serves as a foundation for all view controllers in the application
///
/// This class was added in anticipation of project scaling, following personal development practices.
/// It provides common functionality and properties that would be shared across multiple view controllers
/// as the application grows, promoting code reuse and consistent behavior.
///
/// - Note: This is primarily a placeholder for future expansion and is part of a personal development approach.
class BaseVC<T>: UIViewController where T: BaseVM {
    var viewModel: T?
    let disposeBag = DisposeBag()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension BaseVC: BottomNavbarDelegate {
    func backAction() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }

    func shareAction(url: String) {
        Utils.instance.shareSheet(vc: self, url: url)
    }
}
