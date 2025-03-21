//
//  HomeRepository.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 15.03.2025.
//

import Foundation
import Combine

protocol HomeRepositoryProtocol {
    func getUsers() -> AnyPublisher<[User]?, Error>
}

final class HomeRepository: HomeRepositoryProtocol {
    let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
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
