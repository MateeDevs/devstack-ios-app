//
//  Lce.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import Moya
import RxSwift

// Lce -> Loading / Content / Error
// Idea taken from: https://tech.instacart.com/lce-modeling-data-loading-in-rxjava-b798ac98d80

class Lce<T> {
    var isLoading: Bool
    var hasError: Bool
    var error: ServiceError?
    var data: T?
    
    init(loading: Bool = true) {
        self.isLoading = loading
        self.hasError = false
    }
    
    init(data: T) {
        self.isLoading = false
        self.hasError = false
        self.data = data
    }
    
    init(error: ServiceError) {
        self.isLoading = false
        self.hasError = true
        self.error = error
    }
}
