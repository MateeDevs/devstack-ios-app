//
//  RefreshUserUseCase.swift
//  DevStack
//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRefreshUserUseCase {
    var refreshUserUseCase: RefreshUserUseCase { get }
}

public struct RefreshUserUseCase {
    
    typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(id: String) -> Observable<Event<Void>> {
        dependencies.userRepository.read(.remote, id: id).mapToVoid().materialize()
    }
}
