//
//  UserDetailVC.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import UIKit
import MapKit

final class UserDetailVC: BaseVC<UserDetailVM> {
    @IBOutlet private var back: UIButton!
    @IBOutlet private var share: UIButton!
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        setupTableView()
        setUserInfo()
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.registerCell(cell: UserDetailHeaderCell.self)
        tableView.registerCell(cell: UserInfoCell.self)
    }
    
    @IBAction private func backAction(_ sender: Any) {
        backAction()
        
    }
    
    @IBAction private func shareAction(_ sender: Any) {
        guard let user = viewModel?.user, let websiteUrl = user.website else { return }
        self.shareAction(url: websiteUrl)
    }
}

extension UserDetailVC {
    private func setUserInfo() {
        guard let user = viewModel?.user else { return }
        userName.text = user.name
    }

    private func configureButtons() {
        back.setTitle("", for: .normal)
        share.setTitle("", for: .normal)
    }
}

extension UserDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.cellWithIdentifier(cell: UserDetailHeaderCell.self, for: indexPath)
            cell.user = viewModel?.user
            cell.configureCell()
            return cell
        case 1:
            let cell = tableView.cellWithIdentifier(cell: UserInfoCell.self, for: indexPath)
            cell.user = viewModel?.user
            cell.rootViewController = self
            cell.configureCell()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 200 : 250
    }
}
