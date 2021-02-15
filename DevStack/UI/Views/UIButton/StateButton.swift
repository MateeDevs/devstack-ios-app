//
//  StateButton.swift
//  DevStack
//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class StateButton: UIButton {

    // MARK: UI components

    // MARK: Stored properties
    @IBInspectable public var isOn: Bool = false

    @IBInspectable public var titleOnState: String? {
        didSet {
            updateTitle()
        }
    }

    @IBInspectable public var titleOffState: String? {
        didSet {
            updateTitle()
        }
    }

    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    }
    
    @objc public func didTouchUpInside(_ button: UIButton) {
        isOn = !isOn
        updateTitle()
    }

    // MARK: Additional methods
    private func updateTitle() {
        let titleForState = isOn ? titleOnState : titleOffState
        setTitle(NSLocalizedString(titleForState ?? title(for: .normal) ?? "", comment: ""), for: .normal)
    }
}