//
//  LoginService.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import Moya
import RealmSwift
import RxSwift
import RxRealm
import KeychainAccess

protocol HasLoginService {
    var loginService: LoginService { get }
}

class LoginService: BaseService {
    
    func login(email: String, password: String) -> Observable<Lce<Void>> {
        let endpoint = AuthAPI.login(email: email, password: password)
        let network: Observable<Lce<AuthToken>> = networkStream(endpoint)
        return network.do(onNext: { (event) in
            guard let authToken = event.data else { return }
            KeychainStore.save(key: KeychainCoding.authToken, value: authToken.token)
            KeychainStore.save(key: KeychainCoding.userId, value: authToken.userId)
        }).mapToLceVoid()
    }
    
    func logout() {
        // clear UserDefaults
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        //UserDefaults.standard.synchronize()
        
        // clear KeyChain
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        for key in keychain.allKeys() {
            KeychainStore.delete(key: key)
        }
        
        // clear Realm
        let realm = try! Realm()
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
}
