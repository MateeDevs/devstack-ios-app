//
//  Lce.swift
//  DevStack
//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

/// LCE -> Loading / Content / Error
/// - Idea taken from [LCE in RxJava](https://tech.instacart.com/lce-modeling-data-loading-in-rxjava-b798ac98d80)
public class Lce<T> {
    public let isLoading: Bool
    public let hasError: Bool
    public let error: Error?
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
    
    public init(error: Error) {
        self.isLoading = false
        self.hasError = true
        self.error = error
        self.data = nil
    }
}
