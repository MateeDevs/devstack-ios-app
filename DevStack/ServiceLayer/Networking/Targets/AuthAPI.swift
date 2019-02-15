//
//  AuthAPI.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/12/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import Moya

enum AuthAPI {
    case login(email: String, password: String)
    case register(email: String, password: String, user: User)
}

extension AuthAPI: TargetType {
    var baseURL: URL { return URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .register:
            return .post
        }
    }
    var headers: [String: String]? {
        return nil
    }
    var task: Task {
        switch self {
        case .login(let email, let password):
            let params: [String: Any] = [
                "email": email,
                "pass": password
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .register(let email, let password, let user):
            var params = user.dictionary
            params["email"] = email
            params["password"] = password
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .login:
            return NetworkingUtilities.stubbedResponse("AuthToken")
        case .register:
            return NetworkingUtilities.stubbedResponse("User")
        }
    }
}
