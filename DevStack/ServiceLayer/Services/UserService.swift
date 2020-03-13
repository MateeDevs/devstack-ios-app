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
        return database.observableCollection(User.self)
    }
    
    public func downloadUsersForPage(_ page: Int) -> Observable<Lce<[User]>> {
        let endpoint = UserAPI.getUsersForPage(page)
        return network.observableRequest(endpoint).map([User].self, atKeyPath: "data").save().mapToLce()
    }
    
    public func getUserById(_ id: String) -> Observable<Lce<User>> {
        return database.observableObject(User.self, id: id)
    }
    
    public func downloadUserById(_ id: String) -> Observable<Lce<User>> {
        let endpoint = UserAPI.getUserById(id)
        return network.observableRequest(endpoint).map(User.self).save().mapToLce()
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
