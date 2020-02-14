// 
//  UserDetailViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import RxCocoa

final class UserDetailViewModel: ViewModel, ViewModelType {

    typealias Dependencies = HasUserService
    fileprivate let dependencies: Dependencies

    private var userId: String

    init(dependencies: Dependencies, userId: String) {
        self.dependencies = dependencies
        self.userId = userId
        super.init()
    }

    struct Input {
    }

    struct Output {
        let getUserDetailEvent: Driver<Lce<User>>
    }

    func transform(input: Input) -> Output {
        let getUserDetailEvent: Driver<Lce<User>> = dependencies.userService.getUserById(userId).asDriverOnErrorJustComplete()
        return Output(getUserDetailEvent: getUserDetailEvent)
    }
}
