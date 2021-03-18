//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public struct LoginData: Equatable {
    public let email: String
    public let pass: String
    
    public init(
        email: String,
        pass: String
    ) {
        self.email = email
        self.pass = pass
    }
}
