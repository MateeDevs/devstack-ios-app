//
//  TickButton.swift
//  DevStack
//
//  Created by Petr Chmelar on 27/10/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

@IBDesignable open class TickButton: UIButton {

    // MARK: Stored properties
    public var isOn: Bool = false {
        didSet {
            setupImage()
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
        setupImage()
        setTitle("", for: .normal)
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    }

    // MARK: Additional methods
    private func setupImage() {
        let image = isOn ? Asset.Images.checkboxOn.image : Asset.Images.checkboxOff.image
        setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }

    @objc private func didTouchUpInside(_ button: UIButton) {
        isOn = !isOn
    }
}
