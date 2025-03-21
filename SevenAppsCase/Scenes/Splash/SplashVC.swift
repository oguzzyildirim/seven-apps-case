//
//  SplashVC.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 12.03.2025.
//

import UIKit
import RxSwift

final class SplashVC: BaseVC<SplashVM> {
    @IBOutlet private var splashIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashIcon.layer.cornerRadius = 16
    }
}
