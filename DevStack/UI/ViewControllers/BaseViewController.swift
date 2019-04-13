//
//  BaseViewController.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    
    // MARK: Stored properties
    
    /// In case the DisposeBag not to be emptied. Thus keep the same subscriptions for whole life cycle.
    public var allowRecyclingBag: Bool = true
    
    private var bag: DisposeBag = DisposeBag()
    private(set) var disposeBag: DisposeBag {
        get {
            return bag
        }
        set(value) {
            if allowRecyclingBag {
                bag = value
            }
        }
    }
    
    // MARK: Inits
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        Logger.info("%@ initialized", "\(type(of: self))", category: .lifecycle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
        // As long as viewWillAppear make sure to setup your viewModel
        setupViewModel()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove the current reference to the disposeBag so all current subscriptions are disposed
        disposeBag = DisposeBag()
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Default methods
    
    /// Override this method in a subclass and setup the view model
    open func setupViewModel() {
        // Fresh initializaton of DisposeBag whenever subscriptions are about to initialize
        disposeBag = DisposeBag()
    }
    
    /// Override this method in a subclass and setup the view appearance
    open func setupUI() {
        // Setup background color and back button title
        view.backgroundColor = Asset.Colors.mainBackground.color
        navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.back, style: .plain, target: nil, action: nil)
    }
    
}
