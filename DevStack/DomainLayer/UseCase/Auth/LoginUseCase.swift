//
//  LoginUseCase.swift
//  DevStack
//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasLoginUseCase {
    var loginUseCase: LoginUseCase { get }
}

public struct LoginUseCase {
    
    typealias Dependencies = HasAuthTokenRepository
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(_ data: LoginData) -> Observable<Event<Void>> {
        dependencies.authTokenRepository.create(data).mapToVoid().materialize()
    }
}
