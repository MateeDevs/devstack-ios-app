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
    
    private let network: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.network = networkProvider
    }
    
    public func login(email: String, password: String) -> Observable<Void> {
        let endpoint = AuthAPI.login(email: email, password: password)
        return network.observableRequest(endpoint, withInterceptor: false).map(AuthToken.self).do(onNext: { authToken in
            KeychainProvider.save(.authToken, value: authToken.token)
            KeychainProvider.save(.userId, value: authToken.userId)
        }).mapToVoid()
    }
    
    public func registration(email: String, password: String, firstName: String, lastName: String) -> Observable<User> {
        let user = User(value: ["firstName": firstName, "lastName": lastName])
        let endpoint = AuthAPI.registration(email: email, password: password, user: user)
        return network.observableRequest(endpoint).map(User.self).save()
    }
    
    public static func logout() {
        // Clear KeyChain
        KeychainProvider.deleteAll()
        
        // Clear Realm
        guard let realm = Realm.safeInit() else { return }
        do {
            try realm.safeWrite {
                realm.deleteAll()
            }
        } catch let error as NSError {
            Logger.error("Error during Realm deleteAll operation:\n%@", "\(error)", category: .app)
        }
    }
    
}
