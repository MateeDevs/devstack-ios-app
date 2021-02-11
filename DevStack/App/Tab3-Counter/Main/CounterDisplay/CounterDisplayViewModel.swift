//
//  CounterDisplayViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

final class CounterDisplayViewModel: ViewModel, ViewModelType {

    typealias Dependencies = HasUserRepository

    let input: Input
    let output: Output

    struct Input {
    }

    struct Output {
        let counterValue: Driver<String>
    }

    init(dependencies: Dependencies) {

        // MARK: Setup inputs

        self.input = Input()

        // MARK: Setup outputs

        self.output = Output(
            counterValue: dependencies.userRepository.getProfile().map { "\($0.counter)" }.asDriver()
        )

        super.init()
    }
}
