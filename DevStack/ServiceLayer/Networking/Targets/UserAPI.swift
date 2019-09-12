//
//  UserAPI.swift
//  DevStack
//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import Moya

enum UserAPI {
    case getUsersForPage(_ page: Int)
    case getUserById(_ id: String)
    case updateUser(_ user: User)
}

extension UserAPI: TargetType {
    var baseURL: URL { return URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .getUsersForPage:
            return "/user"
        case .getUserById(let id):
            return "/user/\(id)"
        case .updateUser(let user):
            return "/user/\(user.id)"
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
    var headers: [String: String]? {
        return nil
    }
    var task: Task {
        switch self {
        case .getUsersForPage(let page):
            let params: [String: Any] = [
                "page" : page,
                "limit" : NetworkingConstants.paginationCount
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .updateUser(let user):
            return .requestParameters(parameters: user.dictionary, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .getUsersForPage:
            return NetworkingUtilities.stubbedResponse("UserList")
        case .getUserById, .updateUser:
            return NetworkingUtilities.stubbedResponse("User")
        }
    }
}
