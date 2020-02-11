//
//  UserService.swift
//  DevStack
//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import RxSwift

public protocol HasUserService {
    var userService: UserService { get }
}

public class UserService {
    
    private let database = DatabaseManager()
    private let network = NetworkManager()
    
    public func getUsers() -> Observable<Lce<[User]>> {
        let db = database.observableCollection(User.self)
        return db
    }
    
    public func downloadUsersForPage(_ page: Int) -> Observable<Lce<[User]>> {
        let endpoint = UserAPI.getUsersForPage(page)
        return network.observableRequest(endpoint).map([User].self, atKeyPath: "data").save().mapToLce()
    }
    
    public func getUserById(_ id: String) -> Observable<Lce<User>> {
        let db = database.observableObject(User.self, id: id)
        let endpoint = UserAPI.getUserById(id)
        let net = network.observableRequest(endpoint).map(User.self).save().mapToLce().filter({ $0.hasError })
        return Observable.merge(db, net).startWith(Lce(loading: true))
    }
    
    public func updateUser(_ user: User) -> Observable<Lce<User>> {
        let endpoint = UserAPI.updateUser(user)
        return network.observableRequest(endpoint).map(User.self).save().mapToLce()
    }
    
    public func getProfile() -> Observable<Lce<User>> {
        if let userId = KeychainStore.get(.userId) {
            return getUserById(userId)
        } else {
            return Observable.just(Lce(error: CommonError.noUserId))
        }
    }
    
}
