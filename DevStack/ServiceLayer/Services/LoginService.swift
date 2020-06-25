//
//  LoginService.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

public protocol HasLoginService {
    var loginService: LoginService { get }
}

public class LoginService {

    typealias Dependencies = HasDatabaseProvider & HasKeychainProvider & HasNetworkProvider

    private let database: DatabaseProviderType
    private let keychain: KeychainProviderType
    private let network: NetworkProviderType
    
    init(dependencies: Dependencies) {
        self.database = dependencies.databaseProvider
        self.keychain = dependencies.keychainProvider
        self.network = dependencies.networkProvider
    }
    
    public func login(email: String, password: String) -> Observable<Void> {
        let endpoint = AuthAPI.login(email: email, password: password)
        return network.observableRequest(endpoint, withInterceptor: false).map(AuthToken.self).do(onNext: { authToken in
            self.keychain.save(.authToken, value: authToken.token)
            self.keychain.save(.userId, value: authToken.userId)
        }).mapToVoid()
    }
    
    public func registration(email: String, password: String, firstName: String, lastName: String) -> Observable<User> {
        let user = User(value: ["firstName": firstName, "lastName": lastName])
        let endpoint = AuthAPI.registration(email: email, password: password, user: user)
        return network.observableRequest(endpoint).map(User.self).save()
    }
    
    public func logout() -> Observable<Void> {
        keychain.deleteAll()
        database.deleteAll()
        return Observable.just(())
    }
    
}
