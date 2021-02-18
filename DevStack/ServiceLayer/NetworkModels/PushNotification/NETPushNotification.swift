//
//  NETPushNotification.swift
//  DevStack
//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

struct NETPushNotification: Decodable {
    let aps: APS
    let type: Int
    let entity_id: String
    
    struct APS: Decodable {
        let alert: APSAlert
    }

    struct APSAlert: Decodable {
        let title: String
        let body: String
    }
}

// Conversion from NetworkModel to DomainModel
extension NETPushNotification: DomainRepresentable {
    typealias DomainModel = PushNotification
    
    var domainModel: DomainModel {
        PushNotification(
            title: aps.alert.title,
            body: aps.alert.body,
            type: PushNotificationType(rawValue: type) ?? .info,
            entityId: entity_id
        )
    }
}
