//
//  UpdateProfileCounterUseCase.swift
//  DevStack
//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasUpdateProfileCounterUseCase {
    var updateProfileCounterUseCase: UpdateProfileCounterUseCase { get }
}

public struct UpdateProfileCounterUseCase {
    
    typealias Dependencies =
        HasAuthTokenRepository &
        HasUserRepository
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(value: Int) -> Observable<Event<Void>> {
        guard let authToken = dependencies.authTokenRepository.read() else { return .error(CommonError.noAuthToken) }
        return dependencies.userRepository.read(.local, id: authToken.userId).take(1)
            .flatMap { profile -> Observable<User> in
                let updatedProfile = User(copy: profile, counter: profile.counter + value)
                return dependencies.userRepository.update(.local, user: updatedProfile)
            }.mapToVoid().materialize()
    }
}
