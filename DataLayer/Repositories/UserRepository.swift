//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RxSwift

public struct UserRepositoryImpl: UserRepository {
    
    public typealias Dependencies =
        HasDatabaseProvider &
        HasKeychainProvider &
        HasNetworkProvider

    private let database: DatabaseProvider
    private let keychain: KeychainProvider
    private let network: NetworkProvider

    public init(dependencies: Dependencies) {
        self.database = dependencies.databaseProvider
        self.keychain = dependencies.keychainProvider
        self.network = dependencies.networkProvider
    }
    
    public func create(_ data: RegistrationData) -> Observable<User> {
        guard let data = data.networkModel.encoded else { return .error(CommonError.encoding) }
        let endpoint = AuthAPI.registration(data)
        return network.observableRequest(endpoint).map(NETUser.self).mapToDatabase().save().mapToDomain()
    }
    
    public func read(_ sourceType: SourceType, id: String) -> Observable<User> {
        let db = database.observableObject(DBUser.self, id: id)
        let endpoint = UserAPI.getUserById(id)
        let net = network.observableRequest(endpoint).map(NETUser.self).mapToDatabase().save()
        return sourceType.result(db: db.mapToDomain(), net: net.mapToDomain())
    }
    
    public func list(_ sourceType: SourceType, page: Int, sortBy: String?) -> Observable<[User]> {
        let db = database.observableCollection(DBUser.self, sortBy: sortBy)
        let endpoint = UserAPI.getUsersForPage(page)
        let net = network.observableRequest(endpoint).map([NETUser].self, atKeyPath: "data").mapToDatabase().save()
        return sourceType.result(db: db.mapToDomain(), net: net.mapToDomain())
    }
    
    public func update(_ sourceType: SourceType, user: User) -> Observable<User> {
        let db = database.save(user.databaseModel, model: .fullModel)
        guard let data = user.networkModel.encoded else { return .error(CommonError.encoding) }
        let endpoint = UserAPI.updateUserById(user.id, data: data)
        let net = network.observableRequest(endpoint).map(NETUser.self).mapToDatabase().save()
        return sourceType.result(db: db.mapToDomain(), net: net.mapToDomain())
    }
}
