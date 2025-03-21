//
//  UserMapper.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import Foundation
import Combine

final class UserMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> [User]? {
        if response.statusCode == 200 {
            let product = try JSONDecoder().decode([User]?.self, from: data)
            return product
        }
        
        if response.statusCode >= 400 || response.statusCode <= 500 {
            throw APIErrorHandler.requestFailed
        }

        if let error = try? JSONDecoder()
            .decode(ApiErrorDTO.self, from: data) {
            throw APIErrorHandler.customApiError(error)
        } else {
            throw APIErrorHandler
                .emptyErrorWithStatusCode(response.statusCode.description)
        }
    }
}
