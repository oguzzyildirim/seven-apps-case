//
//  UserMapper.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import Foundation
import Combine

/// Utility class responsible for mapping API responses to User model objects
///
/// This mapper transforms HTTP responses into domain models or error cases,
/// handling the decoding process and appropriate error mapping for different scenarios.
final class UserMapper {
    /// Maps HTTP response data to User objects or throws appropriate errors
    /// - Parameters:
    ///   - data: Raw response data
    ///   - response: HTTP response with status code
    /// - Returns: Array of User objects or nil
    /// - Throws: Various APIErrorHandler cases based on the response
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
