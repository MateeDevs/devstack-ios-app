//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public struct RegistrationData {
    public let email: String
    public let pass: String
    public let firstName: String
    public let lastName: String
    
    public init(
        email: String,
        pass: String,
        firstName: String,
        lastName: String
    ) {
        self.email = email
        self.pass = pass
        self.firstName = firstName
        self.lastName = lastName
    }
}
