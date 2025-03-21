//
//  ApiEndpoint.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import Foundation

protocol ApiEndpoint {
    var baseURLString: String { get }
    var apiVersion: String? { get }
    var separatorPath: String? { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var params: [String: Any]? { get }
    var method: APIHTTPMethod { get }
    var customDataBody: Data? { get }
}

extension ApiEndpoint {
    var makeRequest: URLRequest {
        guard let urlComponents = createURLComponents() else {
            fatalError("Could not create URL components from: \(baseURLString)")
        }
        
        guard let url = urlComponents.url else {
            fatalError("Could not create URL from components: \(urlComponents)")
        }
        
        var request = URLRequest(url: url)
        configureRequest(&request)
        
        return request
    }
    
    // MARK: - Private helpers
    
    private func createURLComponents() -> URLComponents? {
        guard var components = URLComponents(string: baseURLString) else {
            return nil
        }
        
        components.path = getFullPath()
        components.queryItems = queryItems
        
        return components
    }
    
    private func configureRequest(_ request: inout URLRequest) {
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        setRequestBody(for: &request)
    }
    
    private func setRequestBody(for request: inout URLRequest) {
        if let customDataBody = customDataBody {
            request.httpBody = customDataBody
        } else if let params = params {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: params)
                request.httpBody = jsonData
                
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
            } catch {
                print("JSON serialization error: \(error)")
            }
        }
    }
    
    private func getFullPath() -> String {
        var components: [String] = []
        
        if let apiVersion = apiVersion { components.append(apiVersion) }
        if let separatorPath = separatorPath { components.append(separatorPath) }
        components.append(path)
        
        return "/" + components.joined(separator: "/")
    }
}
