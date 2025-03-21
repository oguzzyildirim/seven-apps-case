//
//  HomeVC.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 18.03.2025.
//

import UIKit

final class HomeVC: BaseVC<HomeVM> {
    @IBOutlet private var searchField: UIView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet var searchTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        setupSearchTF()
        setupTableView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidAppear()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(cell: UserCell.self)
    }
    
    private func setupSearchTF() {
        searchTF.delegate = self
        searchTF.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    @objc private func searchTextChanged(_ textField: UITextField) {
        guard let searchText = textField.text else { return }
        viewModel?.filterUsers(with: searchText)
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.$filteredUsers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITextFieldDelegate
extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filteredUsers = viewModel?.filteredUsers else {
            LogManager.shared.warning("No users")
            return 0
        }
        return filteredUsers.count
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel?.filteredUsers[indexPath.row]
        _ = UserDetailCoordinator(rootViewController: self, user: user).start()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cellWithIdentifier(cell: UserCell.self, for: indexPath)
        guard let filteredUsers = viewModel?.filteredUsers else {
            return cell
        }
        cell.user = filteredUsers[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}
