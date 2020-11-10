//
//  TickButton+Rx.swift
//  DevStack
//
//  Created by Petr Chmelar on 30/10/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

public extension Reactive where Base: TickButton {
    /// Reactive wrapper for `isOn` property.
    var isOn: ControlProperty<Bool> {
        return value
    }

    /// Reactive wrapper for `isOn` property.
    var value: ControlProperty<Bool> {
        return controlProperty(
            editingEvents: [.touchUpInside],
            getter: { base in
                base.isOn
            },
            setter: { base, value in
                base.isOn = value
            }
        )
    }
}
