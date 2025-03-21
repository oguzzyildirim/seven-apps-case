//
//  UserInfoCell.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import UIKit
import SafariServices

final class UserInfoCell: UITableViewCell {
    @IBOutlet private var companyName: UILabel!
    @IBOutlet private var website: UILabel!
    @IBOutlet private var adress: UILabel!
    @IBOutlet private var phoneNumber: UILabel!
    var user: User?
    unowned var rootViewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupWebsite()
    }
    
    func configureCell() {
        guard let user else { return }
        companyName.text = user.company?.name
        website.text = user.website
        adress.text = user.address?.city
        phoneNumber.text = user.phone
    }
    
    private func setupWebsite() {
        website.textColor = .systemBlue
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteTapped))
        website.isUserInteractionEnabled = true
        website.addGestureRecognizer(tapGesture)
    }
    
    @objc private func websiteTapped() {
        guard let websiteUrl = user?.website, !websiteUrl.isEmpty else { return }
        
        let urlString = websiteUrl.hasPrefix("http") ? websiteUrl : "https://\(websiteUrl)"
        guard let url = URL(string: urlString) else { return }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.website.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.website.alpha = 1.0
            }
            
            let safariVC = SFSafariViewController(url: url)
            self.rootViewController?.present(safariVC, animated: true)
        }
    }
}
