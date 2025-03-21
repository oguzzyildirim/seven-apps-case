//
//  HomeRepository.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 15.03.2025.
//

import Foundation
import Combine

/// Protocol defining the data operations required for the Home screen
///
/// This protocol abstracts the data layer operations needed by the Home screen,
/// allowing for easier testing and implementation swapping.
protocol HomeRepositoryProtocol {
    func getUsers() -> AnyPublisher<[User]?, Error>
}

final class HomeRepository: HomeRepositoryProtocol {
    /// Service responsible for user-related API operations
    let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    /// Retrieves a list of users from the user service
    ///
    /// This method:
    /// 1. Calls the user service to fetch users
    /// 2. Ensures results are delivered on the main thread
    /// 3. Logs completion status or errors
    ///
    /// - Returns: A publisher that emits an array of User objects or nil if no users are found
    func getUsers() -> AnyPublisher<[User]?, Error> {
        return userService.getUsers()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { users in
            }, receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    LogManager.shared.error(error)
                case .finished:
                    LogManager.shared.info("User fetch finished")
                }
            })
            .eraseToAnyPublisher()
    }
}
