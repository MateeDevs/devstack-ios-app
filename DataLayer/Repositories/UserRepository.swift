//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RxSwift

public protocol HasUserRepository {
    var userRepository: UserRepository { get }
}

public class UserRepository {
    
    typealias Dependencies =
        HasDatabaseProvider &
        HasKeychainProvider &
        HasNetworkProvider

    private let database: DatabaseProviderType
    private let keychain: KeychainProviderType
    private let network: NetworkProviderType

    init(dependencies: Dependencies) {
        self.database = dependencies.databaseProvider
        self.keychain = dependencies.keychainProvider
        self.network = dependencies.networkProvider
    }
    
    public func create(_ data: RegistrationData) -> Observable<User> {
        guard let data = data.networkModel.encoded else { return .error(CommonError.encoding) }
        let endpoint = AuthAPI.registration(data)
        return network.observableRequest(endpoint).map(NETUser.self).save()
    }
    
    public func read(_ sourceType: SourceType, id: String) -> Observable<User> {
        let db = database.observableObject(DBUser.self, id: id)
        let endpoint = UserAPI.getUserById(id)
        let net = network.observableRequest(endpoint).map(NETUser.self).save()
        return sourceType.result(db: db, net: net)
    }
    
    public func list(_ sourceType: SourceType, page: Int = 0, sortBy: String? = nil) -> Observable<[User]> {
        let db = database.observableCollection(DBUser.self, sortBy: sortBy)
        let endpoint = UserAPI.getUsersForPage(page)
        let net = network.observableRequest(endpoint).map([NETUser].self, atKeyPath: "data").save()
        return sourceType.result(db: db, net: net)
    }
    
    public func update(_ sourceType: SourceType, user: User) -> Observable<User> {
        let db = database.save(user, model: .fullModel)
        guard let data = user.networkModel.encoded else { return .error(CommonError.encoding) }
        let endpoint = UserAPI.updateUserById(user.id, data: data)
        let net = network.observableRequest(endpoint).map(NETUser.self).save()
        return sourceType.result(db: db, net: net)
    }
}
