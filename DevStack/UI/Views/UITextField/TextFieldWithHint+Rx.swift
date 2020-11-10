//
//  TextFieldWithHint+Rx.swift
//  DevStack
//
//  Created by Petr Chmelar on 29/10/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

public extension Reactive where Base: TextFieldWithHint {
    /// Bindable sink for `title` property
    var title: Binder<String> {
        Binder(base) { base, title in
            base.title = title
        }
    }

    /// Bindable sink for `placeholder` property
    var placeholder: Binder<String> {
        return Binder(base) { base, placeholder in
            base.placeholder = placeholder
        }
    }

    /// Reactive wrapper for `text` property.
    var text: ControlProperty<String> {
        return base.textField.rx.text.orEmpty
    }

    /// Bindable sink for `hint` property
    var hint: Binder<String> {
        return Binder(base) { base, hint in
            base.hint = hint
        }
    }
}
