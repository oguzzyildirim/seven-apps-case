//
//  ReactiveCoordinator.swift
//  SevenAppsCase
//
//  Created by Oguz Yildirim on 12.03.2025.
//

import Foundation
import RxSwift

open class ReactiveCoordinator<ResultType>: NSObject {
    public let disposeBag = DisposeBag()
    private let identifier = UUID()

    private func store<T>(coordinator _: ReactiveCoordinator<T>) { }

    private func release<T>(coordinator _: ReactiveCoordinator<T>) { }

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
