//
//  Lce.swift
//  DevStack
//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

/// LCE -> Loading / Content / Error
/// - Idea taken from [LCE in RxJava](https://tech.instacart.com/lce-modeling-data-loading-in-rxjava-b798ac98d80)
public enum Lce<T> {
    case loading
    case content(T)
    case error(Error)
}
