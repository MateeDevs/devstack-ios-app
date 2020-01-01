//
//  LoginServiceMock.swift
//  DevStackTests
//
//  Created by Matee on 30/12/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit
import RxSwift

@testable import DevStack

class LoginServiceMock: NSObject, HasLoginService {
    
    var loginService = LoginService()
    
}
