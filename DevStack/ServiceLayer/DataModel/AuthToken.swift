//
//  AuthToken.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

final class AuthToken: Codable {
    
    // MARK: API properties
    var userId: String = ""
    var email: String = ""
    var token: String = ""
    
    // Commented code below is just for show case purpose
    // It is synthesized automatically and therefore should be omitted if you don't need to change it
    
//    // MARK: Mapping
//    enum CodingKeys: String, CodingKey {
//        case userId
//        case email
//        case token
//    }
//
//    // MARK: Decodable
//    public convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        userId = try container.decodeIfPresent(String.self, forKey: .userId) ?? ""
//        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
//        token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
//    }
//
//    // MARK: Encodable
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(userId, forKey: .userId)
//        try container.encodeIfPresent(email, forKey: .email)
//        try container.encodeIfPresent(token, forKey: .token)
//    }

}
