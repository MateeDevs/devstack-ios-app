//
//  CounterControlViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

final class CounterControlViewModel: ViewModel, ViewModelType {

    typealias Dependencies = HasUserRepository

    let input: Input
    let output: Output

    struct Input {
        let increaseButtonTaps: AnyObserver<Void>
        let decreaseButtonTaps: AnyObserver<Void>
    }

    struct Output {
        let increaseCounter: Driver<Void>
        let decreaseCounter: Driver<Void>
    }

    init(dependencies: Dependencies) {

        // MARK: Setup inputs

        let increaseButtonTaps = PublishSubject<Void>()
        let decreaseButtonTaps = PublishSubject<Void>()

        self.input = Input(
            increaseButtonTaps: increaseButtonTaps.asObserver(),
            decreaseButtonTaps: decreaseButtonTaps.asObserver()
        )

        // MARK: Transformations

        let increaseCounter = increaseButtonTaps.flatMapLatest { _ -> Observable<Event<Void>> in
            dependencies.userRepository.increaseCounter()
        }

        let decreaseCounter = decreaseButtonTaps.flatMapLatest { _ -> Observable<Event<Void>> in
            dependencies.userRepository.decreaseCounter()
        }

        // MARK: Setup outputs

        self.output = Output(
            increaseCounter: increaseCounter.compactMap { $0.element }.asDriver(),
            decreaseCounter: decreaseCounter.compactMap { $0.element }.asDriver()
        )

        super.init()
    }
}