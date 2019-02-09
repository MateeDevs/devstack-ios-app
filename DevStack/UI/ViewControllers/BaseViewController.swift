//
//  BaseViewController.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    /// In case the DisposeBag not to be emptied.
    /// Thus keep the same subscriptions for whole life cycle.
    public var allowRecyclingBag : Bool = true
    
    fileprivate var bag : DisposeBag = DisposeBag()
    public var disposeBag : DisposeBag {
        set(value) {
            if allowRecyclingBag {
                bag = value
            }
        }
        get {
            return bag
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // As long as viewWillAppear make sure to setup your viewModel
        setupViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove the current reference to the disposeBag so all current subscriptions are disposed
        disposeBag = DisposeBag()
    }
    
    /// Method to be overridden in subclasses
    func setupViewModel() {
        // Fresh initializaton of DisposeBag whenever subscriptions are about to initialize
        disposeBag = DisposeBag()
    }
    
    /// Method to be overridden in subclasses
    func setupViewAppearance() {
        view.backgroundColor = Asset.Colors.mainBackground.color
        
        // set back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.back, style: .plain, target: nil, action: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
