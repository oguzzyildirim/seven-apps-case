//
//  UIColor+Ext.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import UIKit

extension UIColor {
    static var appPrimary: UIColor {
        return UIColor(named: "PrimaryColor") ?? .systemBlue
    }
    
    static var appSecondary: UIColor {
        return UIColor(named: "SecondaryColor") ?? .systemGray
    }
    
    static var customCellBackground: UIColor {
        return UIColor(named: "CellBackground") ?? .systemGray
    }
}
