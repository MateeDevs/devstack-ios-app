//
//  Lce.swift
//  DevStack
//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//
// LCE -> Loading / Content / Error
// Idea taken from: https://tech.instacart.com/lce-modeling-data-loading-in-rxjava-b798ac98d80
//

import Foundation

public class Lce<T> {
    public let isLoading: Bool
    public let hasError: Bool
    public let error: ServiceError?
    public let data: T?
    
    public init(loading: Bool) {
        self.isLoading = loading
        self.hasError = false
        self.error = nil
        self.data = nil
    }
    
    public init(data: T) {
        self.isLoading = false
        self.hasError = false
        self.error = nil
        self.data = data
    }
    
    public init(error: ServiceError) {
        self.isLoading = false
        self.hasError = true
        self.error = error
        self.data = nil
    }
}
