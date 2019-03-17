//
//  ViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation

open class ViewModel {
    init() {
        Logger.info("%@ initialized", "\(self)", category: .lifecycle)
    }
    
    deinit {
        Logger.info("%@ deinitialized", "\(self)", category: .lifecycle)
    }
}
