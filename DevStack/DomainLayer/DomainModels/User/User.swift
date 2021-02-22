//
//  User.swift
//  DevStack
//
//  Created by Petr Chmelar on 16.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public struct User {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let phone: String
    let bio: String
    let pictureUrl: String
    let counter: Int
}

public extension User {
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

// Copy constructor
public extension User {
    init(
        copy: User,
        id: String? = nil,
        email: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        phone: String? = nil,
        bio: String? = nil,
        pictureUrl: String? = nil,
        counter: Int? = nil
    ) {
        self.id = id ?? copy.id
        self.email = email ?? copy.id
        self.firstName = firstName ?? copy.firstName
        self.lastName = lastName ?? copy.lastName
        self.phone = phone ?? copy.phone
        self.bio = bio ?? copy.bio
        self.pictureUrl = pictureUrl ?? copy.pictureUrl
        self.counter = counter ?? copy.counter
    }
}
