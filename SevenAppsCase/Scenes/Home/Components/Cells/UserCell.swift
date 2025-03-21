//
//  UserCell.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import UIKit

final class UserCell: UITableViewCell {
    @IBOutlet private var container: UIView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var email: UILabel!
    @IBOutlet private var city: UILabel!
    var user: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        container.layer.cornerRadius = 8
        container.layer.borderWidth = 1
        container.layer.borderColor = AppTheme.shared.secondaryColor.cgColor
    }
    
    func configureCell() {
        guard let user else { return }
        name.text = user.name ?? "-"
        email.text = user.email ?? "-"
        city.text = user.address?.city ?? "-"
    }
}
