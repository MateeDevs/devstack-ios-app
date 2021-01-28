//
//  CounterSharedViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

final class CounterSharedViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasNoService
    
    let input: Input
    let output: Output

    struct Input {
        let hideButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let hideCounterLabel: Driver<Void>
    }
    
    init(dependencies: Dependencies) {

        // MARK: Setup inputs

        let hideButtonTaps = PublishSubject<Void>()

        self.input = Input(
            hideButtonTaps: hideButtonTaps.asObserver()
        )

        // MARK: Setup outputs

        self.output = Output(
            hideCounterLabel: hideButtonTaps.asDriver()
        )
        
        super.init()
    }
}
