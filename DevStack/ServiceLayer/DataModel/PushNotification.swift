//
//  PushNotification.swift
//  DevStack
//
//  Created by Petr Chmelar on 05/04/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation

enum PushNotificationType: Int {
    case info = 1
    case userDetail = 2
}

class PushNotification: Decodable {
    
    // MARK: API properties
    var title: String = ""
    var body: String = ""
    var type: PushNotificationType = .info
    var entityId: String = ""
    
    // MARK: Mapping
    enum CodingKeys: String, CodingKey {
        case aps
        case type
        case entityId = "entity_id"
    }
    
    enum CodingKeysAPS: String, CodingKey {
        case alert
    }
    
    enum CodingKeysAPSAlert: String, CodingKey {
        case title
        case body
    }

    // MARK: Decodable
    public convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let apsContainer = try? container.nestedContainer(keyedBy: CodingKeysAPS.self, forKey: .aps),
            let alertContainer = try? apsContainer.nestedContainer(keyedBy: CodingKeysAPSAlert.self, forKey: .alert) {
            title = try alertContainer.decodeIfPresent(String.self, forKey: .title) ?? ""
            body = try alertContainer.decodeIfPresent(String.self, forKey: .body) ?? ""
        }
        
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type), let typeInt = Int(typeString) {
            type = PushNotificationType(rawValue: typeInt) ?? .info
        }
        
        entityId = try container.decodeIfPresent(String.self, forKey: .entityId) ?? ""
    }
}
