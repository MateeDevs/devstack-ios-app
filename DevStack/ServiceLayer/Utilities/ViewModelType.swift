//
//  ViewModelType.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
