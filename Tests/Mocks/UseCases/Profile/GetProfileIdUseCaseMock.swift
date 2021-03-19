//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

struct GetProfileIdUseCaseMock: GetProfileIdUseCaseType {
    var returnValue: String?
    
    func execute() -> String? {
        return returnValue
    }
}
