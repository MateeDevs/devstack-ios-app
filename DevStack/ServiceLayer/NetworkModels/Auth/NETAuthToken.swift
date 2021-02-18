//
//  NETAuthToken.swift
//  DevStack
//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public struct NETAuthToken: Decodable {
    let userId: String
    let email: String
    let token: String
}
