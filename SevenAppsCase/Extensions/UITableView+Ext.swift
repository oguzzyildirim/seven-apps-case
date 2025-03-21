//
//  UITableView+Ext.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(cell _: T.Type) {
        let nib = UINib(nibName: T.className, bundle: nil)
        register(nib, forCellReuseIdentifier: T.className)
    }
    
    func cellWithIdentifier<T: UITableViewCell>(cell _: T.Type) -> T {
        guard let genericCell = dequeueReusableCell(withIdentifier: T.className) as? T else {
            LogManager.shared.error("Could not dequeue cell with identifier: \(T.className)")
            fatalError("Could not dequeue cell with identifier: \(T.className)")
        }
        return genericCell
    }
    
    func cellWithIdentifier<T: UITableViewCell>(cell _: T.Type, for indexPath: IndexPath) -> T {
        guard let genericCell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            LogManager.shared.error("Could not dequeue cell with identifier: \(T.className) for indexPath: \(indexPath)")
            fatalError("Could not dequeue cell with identifier: \(T.className) for indexPath: \(indexPath)")
        }
        return genericCell
    }
}
