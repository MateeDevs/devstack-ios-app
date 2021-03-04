//
//  RemoteConfigRepository.swift
//  DevStack
//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRemoteConfigRepository {
    var remoteConfigRepository: RemoteConfigRepository { get }
}

public class RemoteConfigRepository {
    
    typealias Dependencies =
        HasRemoteConfigProvider

    private let remoteConfig: RemoteConfigProviderType

    init(dependencies: Dependencies) {
        self.remoteConfig = dependencies.remoteConfigProvider
    }
    
    public func read(_ key: RemoteConfigCoding) -> Observable<Bool> {
        remoteConfig.get(key)
    }
}
