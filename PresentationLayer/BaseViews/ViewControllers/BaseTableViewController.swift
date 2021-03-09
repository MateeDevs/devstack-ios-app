//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import UIKit

open class BaseTableViewController<T>: BaseViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UI components
    // swiftlint:disable:next private_outlet
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
    private var perPage: Int = Constants.paginationCount
    
    // MARK: Lifecycle methods
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentPage = 0
        page.onNext(currentPage)
    }
    
    // MARK: Default methods
    override open func setupBindings() {
        super.setupBindings()
        
        tableView.refreshControl?.rx.controlEvent(.valueChanged).bind(onNext: { [weak self] in
            self?.page.onNext(0)
        }).disposed(by: disposeBag)
    }
    
    override open func setupUI() {
        super.setupUI()
        
        tableView.addRefreshControl()
    }
    
    // MARK: Additional methods
    public func registerCells(_ identifiers: [String]) {
        for identifier in identifiers {
            let cellNib = UINib(nibName: identifier, bundle: Bundle(for: type(of: self)))
            tableView?.register(cellNib, forCellReuseIdentifier: identifier)
        }
    }
    
    public func setData(_ data: [T]) {
        self.items = data
    }
    
    public func updatePaging(_ loadedCount: Int) {
        currentPage += 1
        shouldFetchMore = loadedCount == perPage ? true : false
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
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // Override this method in a subclass and set the estimated height
        BaseTableViewCell.estimatedHeight
    }
}
