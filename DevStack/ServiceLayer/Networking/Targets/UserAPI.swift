//
//  UserAPI.swift
//  DevStack
//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import Moya

enum UserAPI {
    case getUsers()
    case getUserById(_ id: String)
    case updateUser(_ user: User)
}

extension UserAPI: TargetType {
    var baseURL: URL { return URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .getUsers:
            return "/api/user"
        case .getUserById(let id):
            return "/api/user/\(id)"
        case .updateUser(let user):
            return "/api/user/\(user.id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .updateUser:
            return .put
        default:
            return .get
        }
    }
    var headers: [String : String]? {
        return nil
    }
    var task: Task {
        switch self {
        case .updateUser(let user):
            return .requestParameters(parameters: user.dictionary, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .getUsers:
            return NetworkingUtilities.stubbedResponse("UserList")
        case .getUserById, .updateUser:
            return NetworkingUtilities.stubbedResponse("User")
        }
    }
}
