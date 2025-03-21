//
//  UserDetailVMProtocol.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import Foundation

protocol UserDetailVMProtocol: AnyObject {
    // Properties
    var user: User? { get }
    
    // Lifecycle methods
    func viewDidLoad()
}
