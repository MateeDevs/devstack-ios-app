//
//  GetUsersUseCase.swift
//  DevStack
//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasGetUsersUseCase {
    var getUsersUseCase: GetUsersUseCase { get }
}

public struct GetUsersUseCase {
    
    typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> Observable<[User]> {
        dependencies.userRepository.list(.local, sortBy: "id")
    }
}
