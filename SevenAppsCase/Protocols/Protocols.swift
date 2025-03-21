//
//  Protocols.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import Foundation

protocol BottomNavbarDelegate: AnyObject {
    func backAction()
    func shareAction(url: String)
}
