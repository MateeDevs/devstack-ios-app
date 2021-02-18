//
//  AuthRepository.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

public protocol HasAuthRepository {
    var authRepository: AuthRepository { get }
}

public class AuthRepository {

    typealias Dependencies = HasDatabaseProvider & HasKeychainProvider & HasNetworkProvider

    private let database: DatabaseProviderType
    private let keychain: KeychainProviderType
    private let network: NetworkProviderType
    
    init(dependencies: Dependencies) {
        self.database = dependencies.databaseProvider
        self.keychain = dependencies.keychainProvider
        self.network = dependencies.networkProvider
    }
    
    public func login(_ data: LoginData) -> Observable<Event<Void>> {
        let endpoint = AuthAPI.login(data)
        return network.observableRequest(endpoint, withInterceptor: false).map(NETAuthToken.self).do(onNext: { authToken in
            self.keychain.save(.authToken, value: authToken.token)
            self.keychain.save(.userId, value: authToken.userId)
        }).mapToVoid().materialize()
    }
    
    public func registration(_ data: RegistrationData) -> Observable<Event<Void>> {
        let endpoint = AuthAPI.registration(data)
        return network.observableRequest(endpoint).map(NETUser.self).map { $0.domainModel }.save().mapToVoid().materialize()
    }
    
    public func logout() -> Observable<Event<Void>> {
        .deferred {
            self.keychain.deleteAll()
            self.database.deleteAll()
            return Observable.just(()).materialize()
        }
    }
    
}
