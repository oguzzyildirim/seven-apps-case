//
//  LogManager.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 20.03.2025.
//

import Foundation

final class LogManager: NSObject {
    override private init() {}

    static let shared = LogManager()

    func infoWithSuccess(_ message: Any...) {
        log(type: "✅", message: message)
    }
    
    func info(_ message: Any...) {
        log(type: "ℹ️", message: message)
    }

    func error(_ message: Any...) {
        log(type: "❌", message: message)
    }

    func warning(_ message: Any...) {
        log(type: "⚠️", message: message)
    }

    private func log(type: String, message: Any...) {
        let combinedString = message.map { String(describing: $0) }.joined(separator: " ")
        let logString = [type, " SevenApps-Logger --> ", combinedString]
            .map { String(describing: $0) }
            .joined(separator: "")
        print(logString)
    }
}
