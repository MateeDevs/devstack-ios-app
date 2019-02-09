//
//  UserService.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol HasUserService {
    var userService: UserService { get }
}

class UserService: BaseService {
    
    func getUser() -> Observable<Lce<[User]>> {
        return dbStream()
    }
    
    func downloadUsersForPage(_ page: Int) -> Observable<Lce<[User]>> {
        let endpoint = UserAPI.getUsers()
        return networkStream(endpoint).save().startWith(Lce(loading: true))
    }
    
    func getUserById(_ id: String) -> Observable<Lce<User>> {
        let db: Observable<Lce<User>> = dbStream(id: id)
        let endpoint = UserAPI.getUserById(id)
        let network: Observable<Lce<User>> = networkStream(endpoint).save()
        return Observable.merge(db, network).startWith(Lce(loading: true))
    }
    
    func updateUser(_ user: User) -> Observable<Lce<User>> {
        let endpoint = UserAPI.updateUser(user)
        return networkStream(endpoint).save().startWith(Lce(loading: true))
    }
    
}
