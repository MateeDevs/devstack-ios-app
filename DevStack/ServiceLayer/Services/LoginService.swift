//
//  LoginService.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

public protocol HasLoginService {
    var loginService: LoginService { get }
}

public class LoginService {
    
    private let database = DatabaseManager()
    private let network = NetworkManager()
    
    public func login(email: String, password: String) -> Observable<Lce<Void>> {
        let endpoint = AuthAPI.login(email: email, password: password)
		let errors = LceErrors(messages: [401: L10n.invalid_credentials], defaultMessage: L10n.signing_failed)
        return network.observableRequest(endpoint, withInterceptor: false).map(AuthToken.self).do(onNext: { authToken in
            KeychainStore.save(.authToken, value: authToken.token)
            KeychainStore.save(.userId, value: authToken.userId)
        }).mapToLceVoid(errors)
    }
    
    public func registration(email: String, password: String, firstName: String, lastName: String) -> Observable<Lce<User>> {
        let user = User(value: ["firstName": firstName, "lastName": lastName])
        let endpoint = AuthAPI.registration(email: email, password: password, user: user)
        let errors = LceErrors(messages: [409: L10n.register_view_email_already_exists], defaultMessage: L10n.signing_up_failed)
        return network.observableRequest(endpoint).map(User.self).save().mapToLce(errors)
    }
    
    public static func logout() {
        // Clear KeyChain
        KeychainStore.deleteAll()
        
        // Clear Realm
        let realm = try! Realm()
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            Logger.error("Error during Realm deleteAll operation:\n%@", "\(error)", category: .app)
        }
    }
    
}
