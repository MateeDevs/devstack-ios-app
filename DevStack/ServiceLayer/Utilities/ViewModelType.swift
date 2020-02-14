//
//  ViewModelType.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
