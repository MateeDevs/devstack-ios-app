//
//  Created by Petr Chmelar on 19/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

public struct ErrorMessages {
    
    let statusCodes: [StatusCode: String]
    let defaultMessage: String
    
    public init(_ statusCodes: [StatusCode: String], defaultMessage: String) {
        self.statusCodes = statusCodes
        self.defaultMessage = defaultMessage
    }
}
