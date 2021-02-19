//
//  UserRepository.swift
//  DevStack
//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RxSwift

public protocol HasUserRepository {
    var userRepository: UserRepository { get }
}

public class UserRepository {
    
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
    
    public func refreshUsersForPage(_ page: Int) -> Observable<Event<Int>> {
        let endpoint = UserAPI.getUsersForPage(page)
        return network.observableRequest(endpoint).map([User].self, atKeyPath: "data").save().map { $0.count }.materialize()
    }
    
    public func getUserById(_ id: String) -> Observable<User> {
        return database.observableObject(User.self, id: id)
    }
    
    public func refreshUserById(_ id: String) -> Observable<Event<Void>> {
        let endpoint = UserAPI.getUserById(id)
        return network.observableRequest(endpoint).map(User.self).save().mapToVoid().materialize()
    }
    
    public func updateUser(_ user: User) -> Observable<Event<Void>> {
        let endpoint = UserAPI.updateUser(user)
        return network.observableRequest(endpoint).map(User.self).save().mapToVoid().materialize()
    }

    public func increaseCounter() -> Observable<Event<Void>> {
        return getProfile().take(1).flatMap { user -> Observable<User> in
            let userCopy = User(value: user)
            userCopy.counter += 1
            return .just(userCopy)
        }.save(model: .fullModel).mapToVoid().materialize()
    }

    public func decreaseCounter() -> Observable<Event<Void>> {
        return getProfile().take(1).flatMap { user -> Observable<User> in
            let userCopy = User(value: user)
            userCopy.counter -= 1
            return .just(userCopy)
        }.save(model: .fullModel).mapToVoid().materialize()
    }

    public func getProfileId() -> String? {
        return keychain.get(.userId)
    }
    
    public func getProfile() -> Observable<User> {
        guard let userId = getProfileId() else { return .error(CommonError.noUserId) }
        return getUserById(userId)
    }
    
    public func refreshProfile() -> Observable<Event<Void>> {
        guard let userId = getProfileId() else { return .error(CommonError.noUserId) }
        return refreshUserById(userId)
    }
}
