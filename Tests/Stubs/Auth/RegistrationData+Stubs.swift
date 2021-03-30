//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

extension RegistrationData {
    static let empty = RegistrationData(
        email: "",
        password: "",
        firstName: "",
        lastName: ""
    )
    
    static let valid = RegistrationData(
        email: "email@email.com",
        password: "validPassword",
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let invalidEmail = RegistrationData(
        email: "invalidEmail",
        password: "validPassword",
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let existingEmail = RegistrationData(
        email: "existing@email.com",
        password: "validPassword",
        firstName: "Anonymous",
        lastName: ""
    )
}
