//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class XIBView: UIView {

    // MARK: UI components
    var view: UIView! // swiftlint:disable:this implicitly_unwrapped_optional

    // MARK: Stored properties

    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
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
    func configureViews() {
    }

    // MARK: Additional methods
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "\(type(of: self))", bundle: BundleToken.bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else { return nil }
        return view
    }
    
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
