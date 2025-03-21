//
//  UserDetailVM.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import Foundation

final class UserDetailVM: BaseVM, UserDetailVMProtocol {
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func viewDidLoad() {
    }
}
