//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import RxSwift
import UIKit

open class BaseViewController: UIViewController {
    
    // MARK: Stored properties
    private(set) var disposeBag = DisposeBag()
    
    // MARK: Inits
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        Logger.info("%@ initialized", "\(type(of: self))", category: .lifecycle)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger.info("%@ initialized", "\(type(of: self))", category: .lifecycle)
    }
    
    deinit {
        Logger.info("%@ deinitialized", "\(type(of: self))", category: .lifecycle)
    }
    
    // MARK: Lifecycle methods
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // As long as viewWillAppear make sure to setup your reactive bindings
        setupBindings()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove the current reference to the disposeBag so all current subscriptions are disposed
        disposeBag = DisposeBag()
        
        // Ensure that any presented WhisperView is removed
        hideWhisper()
    }
    
    // MARK: Default methods
    
    /// Override this method in a subclass and setup the reactive bindings
    open func setupBindings() {
        // Fresh initializaton of DisposeBag whenever subscriptions are about to initialize
        disposeBag = DisposeBag()
    }
    
    /// Override this method in a subclass and setup the view appearance
    open func setupUI() {
        // Setup background color and back button title
        view.backgroundColor = AppTheme.Colors.background
        navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.back, style: .plain, target: nil, action: nil)
    }
}
