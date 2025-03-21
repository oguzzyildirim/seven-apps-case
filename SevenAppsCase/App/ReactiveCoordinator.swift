//
//  ReactiveCoordinator.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 12.03.2025.
//

import Foundation
import RxSwift

/// Base coordinator class that provides reactive coordination capabilities
///
/// This class serves as the foundation for implementing the coordinator pattern with RxSwift.
/// It handles the coordination between different flows in the application and manages
/// the lifecycle of child coordinators. Each coordinator represents a specific flow or
/// feature in the application.
open class ReactiveCoordinator<ResultType>: NSObject {
    public let disposeBag = DisposeBag()
    private let identifier = UUID()

    private func store<T>(coordinator _: ReactiveCoordinator<T>) { }

    private func release<T>(coordinator _: ReactiveCoordinator<T>) { }

    /// Coordinates to another coordinator and returns its result
    ///
    /// This method:
    /// 1. Stores a reference to the child coordinator
    /// 2. Starts the child coordinator's flow
    /// 3. Automatically releases the child coordinator when its flow completes
    ///
    /// - Parameter coordinator: The child coordinator to coordinate to
    /// - Returns: An observable of the child coordinator's result
    open func coordinate<T>(to coordinator: ReactiveCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.release(coordinator: coordinator)
            })
    }

    open func start() -> Observable<ResultType> {
        fatalError("start() method must be implemented")
    }
}
