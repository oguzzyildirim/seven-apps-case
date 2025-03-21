//
//  UserService.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import Foundation
import Combine
import AVFoundation

protocol UserServiceProtocol: AnyObject {
    func getUsers() -> AnyPublisher<[User]?, Error>
}

final class UserService: UserServiceProtocol {
    
    private let httpClient: HTTPClient
    var subscriptions = Set<AnyCancellable>()
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getUsers() -> AnyPublisher<[User]?, Error> {
        return httpClient
            .publisher(UserProvider.users.makeRequest)
            .tryMap(UserMapper.map)
            .eraseToAnyPublisher()
    }
}
