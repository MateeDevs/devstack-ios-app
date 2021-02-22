//
//  GetUserUseCase.swift
//  DevStack
//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasGetUserUseCase {
    var getUserUseCase: GetUserUseCase { get }
}

public struct GetUserUseCase {
    
    typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(id: String) -> Observable<User> {
        dependencies.userRepository.read(.local, id: id)
    }
}
