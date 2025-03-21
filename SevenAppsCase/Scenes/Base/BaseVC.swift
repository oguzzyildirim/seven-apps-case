//
//  BaseVC.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 12.03.2025.
//

import RxSwift
import Combine
import UIKit

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
