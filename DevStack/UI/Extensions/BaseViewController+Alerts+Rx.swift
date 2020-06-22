//
//  BaseViewController+Alerts+Rx.swift
//  DevStack
//
//  Created by Petr Chmelar on 21/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

public extension Reactive where Base: BaseViewController {
    /// Bindable sink for `handleWhisper()` method
    var whisperAction: Binder<WhisperAction> {
        return Binder(self.base) { base, action in
            base.handleWhisper(action)
        }
    }
}
