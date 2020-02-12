// 
//  LocationDetailViewModel.swift
//  DevStack
//
//  Created by Filip Bodnár on 12/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import RxCocoa

final class LocationDetailViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasNoService
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }
    
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
