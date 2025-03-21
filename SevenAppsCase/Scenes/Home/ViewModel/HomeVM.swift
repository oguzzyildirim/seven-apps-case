//
//  HomeVM.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 15.03.2025.
//

import Foundation
import Combine

final class HomeVM: BaseVM, HomeVMProtocol {
    let repo: HomeRepositoryProtocol
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(repo: HomeRepositoryProtocol) {
        self.repo = repo
        super.init()
    }
    
    /// Called when the view has loaded
    ///
    /// This method is empty but kept for protocol conformance and potential future initialization needs.
    func viewDidLoad() {
    }
    
    func viewDidAppear() {
        self.getUsers()
    }
    
    /// Fetches users from the repository
    ///
    /// This method:
    /// 1. Calls the repository to get user data
    /// 2. Handles success and error cases
    /// 3. Updates both the users and filteredUsers properties on success
    func getUsers() {
        repo.getUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    LogManager.shared.error("Error fetching users: \(error)")
                }
            }, receiveValue: { [weak self] users in
                guard let self = self, let users = users else { return }
                self.users = users
                self.filteredUsers = users
            })
            .store(in: &cancellables)
    }
    
    /// Filters the users based on a search query
    ///
    /// This method filters users by checking if the query string appears in the user's:
    /// - Name
    /// - Username
    /// - Email
    /// - City
    ///
    /// If the query is empty, all users are shown.
    ///
    /// - Parameter query: The search string used to filter users
    func filterUsers(with query: String) {
        if query.isEmpty {
            filteredUsers = users
            return
        }
        
        filteredUsers = users.filter { user in
            let nameMatch = user.name?.lowercased().contains(query.lowercased()) ?? false
            let usernameMatch = user.username?.lowercased().contains(query.lowercased()) ?? false
            let emailMatch = user.email?.lowercased().contains(query.lowercased()) ?? false
            let cityMatch = user.address?.city?.lowercased().contains(query.lowercased()) ?? false
            
            return nameMatch || usernameMatch || emailMatch || cityMatch
        }
    }
}
