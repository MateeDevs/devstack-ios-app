//
//  ViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation
import os.log

class ViewModel {
    
    init() {
        os_log("%@ initialized", log: Logger.lifecycleLog(), type: .info, "\(self)")
    }
    
    deinit {
        os_log("%@ deinitialized", log: Logger.lifecycleLog(), type: .info, "\(self)")
    }
}
