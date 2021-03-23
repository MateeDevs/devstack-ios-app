//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

extension LoginData {
    static let empty = LoginData(email: "", password: "")
    static let valid = LoginData(email: "email@email.com", password: "validPassword")
    static let invalidPassword = LoginData(email: "email@email.com", password: "invalidPassword")
}
