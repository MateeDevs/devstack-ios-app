//
//  GetProfileIdUseCase.swift
//  DevStack
//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol HasGetProfileIdUseCase {
    var getProfileIdUseCase: GetProfileIdUseCase { get }
}

public struct GetProfileIdUseCase {
    
    typealias Dependencies = HasAuthTokenRepository & HasUserRepository
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> String? {
        dependencies.authTokenRepository.read()?.userId
    }
}
