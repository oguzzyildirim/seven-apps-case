//
//  UserInfoCell.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import UIKit

final class UserInfoCell: UITableViewCell {
    @IBOutlet private var companyName: UILabel!
    @IBOutlet private var website: UILabel!
    @IBOutlet private var adress: UILabel!
    @IBOutlet private var phoneNumber: UILabel!
    var user: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        guard let user else { return }
        companyName.text = user.company?.name
        website.text = user.website
        adress.text = user.address?.city
        phoneNumber.text = user.phone
    }
}
