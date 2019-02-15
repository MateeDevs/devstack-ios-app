//
//  BaseViewController.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit
import RxSwift

public class BaseViewController: UIViewController {
    
    // MARK: Stored properties
    
    // In case the DisposeBag not to be emptied.
    // Thus keep the same subscriptions for whole life cycle.
    public var allowRecyclingBag: Bool = true
    
    private var bag: DisposeBag = DisposeBag()
    private(set) var disposeBag: DisposeBag {
        set(value) {
            if allowRecyclingBag {
                bag = value
            }
        }
        get {
            return bag
        }
    }
    
    // MARK: Lifecycle methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViewAppearance()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // As long as viewWillAppear make sure to setup your viewModel
        setupViewModel()
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove the current reference to the disposeBag so all current subscriptions are disposed
        disposeBag = DisposeBag()
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Default methods
    public func setupViewModel() {
        
        // Override this method in a subclass and setup the view model
        
        // Fresh initializaton of DisposeBag whenever subscriptions are about to initialize
        disposeBag = DisposeBag()
    }
    
    public func setupViewAppearance() {
        
        // Override this method in a subclass and setup the view appearance
        
        // Setup background color and back button title
        view.backgroundColor = Asset.Colors.mainBackground.color
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.back, style: .plain, target: nil, action: nil)
    }
    
}
