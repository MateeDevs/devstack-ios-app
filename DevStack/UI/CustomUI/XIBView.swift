//
//  XIBView.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

open class XIBView: UIView {
    
    public var view: UIView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup() {
        guard let nibView = loadViewFromNib() else { return }
        view = nibView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        configureViews()
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(type(of: self))", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else { return nil }
        return view
    }
    
    open func configureViews() {
        // Override this method in a subclass for additional setup
    }
    
}
