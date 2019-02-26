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
import os.log

public protocol HasLoginService {
    var loginService: LoginService { get }
}

public class LoginService {
    
    private let database = DatabaseManager()
    private let network = NetworkManager()
    
    public func login(email: String, password: String) -> Observable<Lce<Void>> {
        let endpoint = AuthAPI.login(email: email, password: password)
        let net = network.observableRequest(endpoint).map(AuthToken.self).do(onNext: { (authToken) in
            KeychainStore.save(key: KeychainCoding.authToken, value: authToken.token)
            KeychainStore.save(key: KeychainCoding.userId, value: authToken.userId)
        }).mapToLceVoid().startWith(Lce(loading: true))
        return net
    }
    
    public func logout() {
        // Clear UserDefaults
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        //UserDefaults.standard.synchronize()
        
        // Clear KeyChain
        KeychainStore.deleteAll()
        
        // Clear Realm
        let realm = try! Realm()
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            os_log("Error during Realm deleteAll operation:\n%@", log: Logger.appLog(), type: .error, "\(error)")
            print(error)
        }
    }
    
}
