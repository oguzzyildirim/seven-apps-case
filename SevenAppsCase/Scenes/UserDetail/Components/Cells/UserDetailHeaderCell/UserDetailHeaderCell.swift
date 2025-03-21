//
//  UserDetailHeaderCell.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import UIKit

class UserDetailHeaderCell: UITableViewCell {
    @IBOutlet private var nickName: UILabel!
    @IBOutlet private var email: UILabel!
    var user: User?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        guard let user else { return }
        nickName.text = user.username
        email.text = user.email
    }
}
