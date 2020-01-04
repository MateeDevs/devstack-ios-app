//
//  BaseTableViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit
import RxSwift

open class BaseTableViewController<T: AnyObject>: BaseViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UI components
    @IBOutlet public weak var tableView: UITableView! {
        didSet {
            // If you need separator add it directly into the cell
            tableView.separatorStyle = .none
        }
    }
    
    // MARK: Stored properties
    private(set) var items: [T] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private(set) var page = PublishSubject<Int>()
    private var shouldFetchMore = false
    private var currentPage: Int = 0
    private var perPage: Int = NetworkingConstants.paginationCount
    private var loadedItems: Int {
        if currentPage == 0 {
            return items.count
        } else {
            return (currentPage * perPage) > items.count ? items.count : (currentPage * perPage)
        }
    }
    private var refreshControl = UIRefreshControl()
    
    // MARK: Lifecycle methods
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup pull to refresh
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = ColorTheme.activityIndicator
        tableView?.refreshControl = refreshControl
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentPage = 0
        page.onNext(currentPage)
    }
    
    // MARK: Additional methods
    @objc private func pullToRefresh(sender: AnyObject) {
        page.onNext(0)
        refreshControl.endRefreshing()
    }
    
    public func registerCells(_ identifiers: [String]) {
        for identifier in identifiers {
            let cellNib = UINib(nibName: identifier, bundle: nil)
            tableView?.register(cellNib, forCellReuseIdentifier: identifier)
        }
    }
    
    public func handleDatabaseData(_ event: Lce<[T]>) {
        guard let items = event.data else { return }
        self.items = items
    }
    
    public func handleNetworkData(_ event: Lce<[T]>) {
        if event.isLoading, items.count == 0 {
            view.startActivityIndicator()
        } else if event.hasError {
            view.stopActivityIndicator()
        } else if let items = event.data {
            view.stopActivityIndicator()
            currentPage += 1
            shouldFetchMore = items.count == perPage ? true : false
        }
    }
    
    // MARK: UIScrollViewDelegate methods
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isNearBottomEdge(), shouldFetchMore else { return }
        shouldFetchMore = false
        page.onNext(currentPage)
    }
    
    // MARK: UITableViewDataSource methods
    open func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Override this method in a subclass and setup the cells
        UITableViewCell()
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Override this method in a subclass and setup the action
    }
    
    // MARK: UITableViewDelegate methods
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
