//
//  AuthAPI.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/12/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import Moya

enum AuthAPI {
    case login(email: String, password: String)
    case registration(email: String, password: String, user: User)
}

extension AuthAPI: TargetType {
    var baseURL: URL { return URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .registration:
            return "/auth/registration"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .registration:
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
        case .registration(let email, let password, let user):
            var params = user.dictionary
            params["email"] = email
            params["pass"] = password
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .login:
            return NetworkingUtilities.stubbedResponse("AuthToken")
        case .registration:
            return NetworkingUtilities.stubbedResponse("User")
        }
    }
}
