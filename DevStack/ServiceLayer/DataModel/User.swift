//
//  User.swift
//  DevStack
//
//  Created by Petr Chmelar on 20/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - User model object
@objcMembers class User: Object, Codable {
    
    // MARK: Stored properties
    dynamic var id: String = ""
    dynamic var email: String = ""
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var phone: String?
    dynamic var bio: String?
    dynamic var pictureUrl: String?
    
    // MARK: Realm API
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Mapping
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName
        case lastName
        case phone
        case bio
        case pictureUrl
    }
    
    // MARK: Decodable
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        pictureUrl = try container.decodeIfPresent(String.self, forKey: .pictureUrl)
    }
    
    // MARK: Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(pictureUrl, forKey: .pictureUrl)
    }
}

// MARK: - Convenience utils
extension User {
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
