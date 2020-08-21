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
    
    typealias Dependencies = HasDatabaseProvider & HasKeychainProvider & HasNetworkProvider

    private let database: DatabaseProviderType
    private let keychain: KeychainProviderType
    private let network: NetworkProviderType

    init(dependencies: Dependencies) {
        self.database = dependencies.databaseProvider
        self.keychain = dependencies.keychainProvider
        self.network = dependencies.networkProvider
    }
    
    public func getUsers() -> Observable<[User]> {
        return database.observableCollection(User.self, sortBy: "id")
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

    public func increaseCounter() -> Observable<User> {
        return getProfile().take(1).flatMap { user -> Observable<User> in
            let userCopy = User(value: user)
            userCopy.counter += 1
            return Observable.just(userCopy)
        }.save(model: .fullModel)
    }

    public func decreaseCounter() -> Observable<User> {
        return getProfile().take(1).flatMap { user -> Observable<User> in
            let userCopy = User(value: user)
            userCopy.counter -= 1
            return Observable.just(userCopy)
        }.save(model: .fullModel)
    }

    public func getProfileId() -> String? {
        return keychain.get(.userId)
    }
    
    public func getProfile() -> Observable<User> {
        guard let userId = getProfileId() else { return Observable.error(CommonError.noUserId) }
        return getUserById(userId)
    }
    
    public func downloadProfile() -> Observable<User> {
        guard let userId = getProfileId() else { return Observable.error(CommonError.noUserId) }
        return downloadUserById(userId)
    }
    
}
