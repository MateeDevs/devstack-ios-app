//
//  BaseTableViewController+Rx.swift
//  DevStack
//
//  Created by Petr Chmelar on 21/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa

extension BaseTableViewController {
    
    // It is not possible to create an `extension Reactive` for generic class
    // Related issue: https://github.com/ReactiveCocoa/ReactiveSwift/issues/238
    
    /// Bindable sink for `setData()` method
    var data: Binder<[T]> {
        return Binder(self) { base, data in
            base.setData(data)
        }
    }
    
    /// Bindable sink for `updatePaging()` method
    var loadedCount: Binder<Int> {
        return Binder(self) { base, count in
            base.updatePaging(count)
        }
    }
    
    /// Bindable sink for refresh indicators
    var isRefreshing: Binder<Bool> {
        return Binder(self) { base, isRefreshing in
            if isRefreshing, base.items.isEmpty {
                base.view.startActivityIndicator()
            } else {
                base.view.stopActivityIndicator()
                base.tableView?.refreshControl?.endRefreshing()
            }
        }
    }
}
