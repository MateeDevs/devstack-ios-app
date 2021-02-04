//
//  XIBView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

open class XIBView: UIView {

    // MARK: UI components
    public var view: UIView! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: Stored properties

    // MARK: Inits
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        guard let nibView = loadViewFromNib() else { return }
        view = nibView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        configureViews()
    }

    /// Override this method in a subclass for additional setup
    open func configureViews() {
    }

    // MARK: Additional methods
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(type(of: self))", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else { return nil }
        return view
    }
    
}
