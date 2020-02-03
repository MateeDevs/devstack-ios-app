//
//  User.swift
//  DevStack
//
//  Created by Petr Chmelar on 20/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers public class User: Object, Codable {
    
    // MARK: API properties
    public dynamic var id: String = ""
    public dynamic var email: String = ""
    public dynamic var firstName: String = ""
    public dynamic var lastName: String = ""
    public dynamic var phone: String?
    public dynamic var bio: String?
    public dynamic var pictureUrl: String?
    
    // MARK: Realm API
    override public static func primaryKey() -> String? {
        "id"
    }
    
    // Commented code below is just for show case purpose
    // It is synthesized automatically and therefore should be omitted if you don't need to change it
    
//    // MARK: Mapping
//    enum CodingKeys: String, CodingKey {
//        case id
//        case email
//        case firstName
//        case lastName
//        case phone
//        case bio
//        case pictureUrl
//    }
//
//    // MARK: Decodable
//    public convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
//        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
//        firstName = try container.decodeIfPresent(String.self, forKey: .firstName) ?? ""
//        lastName = try container.decodeIfPresent(String.self, forKey: .lastName) ?? ""
//        phone = try container.decodeIfPresent(String.self, forKey: .phone)
//        bio = try container.decodeIfPresent(String.self, forKey: .bio)
//        pictureUrl = try container.decodeIfPresent(String.self, forKey: .pictureUrl)
//    }
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(phone, forKey: .phone)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(pictureUrl, forKey: .pictureUrl)
    }
}

extension User {
    public var fullName: String {
        "\(firstName) \(lastName)"
    }
}
