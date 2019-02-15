// 
//  UsersViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit
import RxSwift

protocol UsersFlowDelegate: class {

}

final class UsersViewController: BaseTableViewController<User> {

    // MARK: FlowDelegate
    weak var flowDelegate: UsersFlowDelegate?

    // MARK: ViewModels
    var viewModel: UsersViewModel?

    // MARK: UI components

    // MARK: Stored properties

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells([UserTableViewCell.nameOfClass])
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
        
        let input = UsersViewModel.Input(page: page)
        let output = viewModel?.transform(input: input)
        
        output?.getUsersEvent.drive(onNext: { [weak self] (event) in
            guard let self = self else { return }
            self.handleDatabaseData(event)
        }).disposed(by: disposeBag)
        
        output?.downloadUsersEvent.drive(onNext: { [weak self] (event) in
            guard let self = self else { return }
            self.handleNetworkData(event)
        }).disposed(by: disposeBag)
    }

    override func setupViewAppearance() {
        super.setupViewAppearance()
    }

    // MARK: TableView methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.nameOfClass, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        let user = items[indexPath.row]
        cell.setupWithUser(user)
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row #\(indexPath.row) clicked")
    }

    // MARK: Additional methods
}
