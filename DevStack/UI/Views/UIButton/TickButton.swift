//
//  TickButton.swift
//  DevStack
//
//  Created by Petr Chmelar on 27/10/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

open class TickButton: StateButton {

    // MARK: Stored properties

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
        setImage()
        setTitle("", for: .normal)
    }

    @objc override public func didTouchUpInside(_ button: UIButton) {
        super.didTouchUpInside(button)
        setImage()
    }

    // MARK: Additional methods
    private func setImage() {
        let image = isOn ? Asset.Images.checkboxOn.image : Asset.Images.checkboxOff.image
        setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
