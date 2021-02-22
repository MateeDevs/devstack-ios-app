//
//  PushNotification.swift
//  DevStack
//
//  Created by Petr Chmelar on 05/04/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

public enum PushNotificationType: Int {
    case info = 1
    case userDetail = 2
}

public struct PushNotification {
    let title: String
    let body: String
    let type: PushNotificationType
    let entityId: String
}
