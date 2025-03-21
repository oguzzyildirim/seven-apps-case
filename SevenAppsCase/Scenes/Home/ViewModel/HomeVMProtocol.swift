//
//  HomeVMProtocol.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import Foundation

protocol HomeVMProtocol: AnyObject {
    // Properties
    var users: [User] { get }
    var filteredUsers: [User] { get }
    
    // Lifecycle methods
    func viewDidLoad()
    
    // Data methods
    func getUsers()
}
