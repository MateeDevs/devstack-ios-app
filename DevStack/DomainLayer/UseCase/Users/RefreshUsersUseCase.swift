//
//  DownloadUsersUseCase.swift
//  DevStack
//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRefreshUsersUseCase {
    var refreshUsersUseCase: RefreshUsersUseCase { get }
}

public struct RefreshUsersUseCase {
    
    typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(page: Int) -> Observable<Event<Int>> {
        dependencies.userRepository.list(.remote, page: page).map { $0.count }.materialize()
    }
}
