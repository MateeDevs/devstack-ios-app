//
//  AuthToken.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - AuthToken model object
struct AuthToken: Codable {
    
    // MARK: API properties
    let userId: String = ""
    let email: String = ""
    let token: String = ""
    
//    // MARK: Mapping
//    enum CodingKeys: String, CodingKey {
//        case id
//        case email
//        case token
//    }
//
//    // MARK: Decodable
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
//        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
//        token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
//    }

}
