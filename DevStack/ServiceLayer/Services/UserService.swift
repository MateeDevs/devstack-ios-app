//
//  UserService.swift
//  DevStack
//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RxSwift

public protocol HasUserService {
    var userService: UserService { get }
}

public class UserService {
    
    private let database: DatabaseProvider
    private let network: NetworkProvider
    
    init(databaseProvider: DatabaseProvider, networkProvider: NetworkProvider) {
        self.database = databaseProvider
        self.network = networkProvider
    }
    
    public func getUsers() -> Observable<[User]> {
        return database.observableCollection(User.self)
    }
    
    public func downloadUsersForPage(_ page: Int) -> Observable<[User]> {
        let endpoint = UserAPI.getUsersForPage(page)
        return network.observableRequest(endpoint).map([User].self, atKeyPath: "data").save()
    }
    
    public func getUserById(_ id: String) -> Observable<User> {
        return database.observableObject(User.self, id: id)
    }
    
    public func downloadUserById(_ id: String) -> Observable<User> {
        let endpoint = UserAPI.getUserById(id)
        return network.observableRequest(endpoint).map(User.self).save()
    }
    
    public func updateUser(_ user: User) -> Observable<User> {
        let endpoint = UserAPI.updateUser(user)
        return network.observableRequest(endpoint).map(User.self).save()
    }
    
    public func getProfile() -> Observable<User> {
        if let userId = KeychainProvider.get(.userId) {
            return getUserById(userId)
        } else {
            return Observable.error(CommonError.noUserId)
        }
    }
    
    public func downloadProfile() -> Observable<User> {
        if let userId = KeychainProvider.get(.userId) {
            return downloadUserById(userId)
        } else {
            return Observable.error(CommonError.noUserId)
        }
    }
    
}
