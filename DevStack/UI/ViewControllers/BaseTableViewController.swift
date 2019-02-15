//
//  BaseTableViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

public class BaseTableViewController<T: AnyObject>: BaseViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UI components
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Stored properties
    private(set) var items: [T] = [] {
        didSet {
            self.tableView?.reloadData()
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
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup pull to refresh
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = ColorTheme.mainColor
        tableView?.refreshControl = refreshControl
    }
    
    override public func viewDidAppear(_ animated: Bool) {
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
        if let items = event.data {
            self.items = items
        }
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
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isNearBottomEdge(), shouldFetchMore {
            shouldFetchMore = false
            page.onNext(currentPage)
        }
    }
    
    // MARK: UITableViewDataSource methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Override this method in a subclass and setup the cells
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Override this method in a subclass and setup the action
    }
    
    // MARK: UITableViewDelegate methods
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
