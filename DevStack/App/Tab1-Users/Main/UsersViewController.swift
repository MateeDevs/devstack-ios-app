// 
//  UsersViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit
import RxSwift

protocol UsersFlowDelegate: class {
    func showUserDetail(userId: String)
}

final class UsersViewController: BaseTableViewController<User> {

    // MARK: FlowDelegate
    weak var flowDelegate: UsersFlowDelegate?

    // MARK: ViewModels
    private var viewModel: UsersViewModel!

    // MARK: UI components

    // MARK: Stored properties
    
    // MARK: Inits
    static func instantiate(viewModel: UsersViewModel) -> UsersViewController {
        let vc = StoryboardScene.Users.initialScene.instantiate()
        vc.viewModel = viewModel
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells([UserTableViewCell.nameOfClass])
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
        
        page.bind(to: viewModel.input.page).disposed(by: disposeBag)
        
        viewModel.output.getUsers.drive(onNext: { [weak self] users in
            self?.handleDatabaseData(users)
        }).disposed(by: disposeBag)
        
        viewModel.output.downloadUsers.drive(onNext: { [weak self] lce in
            self?.handleNetworkData(lce)
        }).disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        
		navigationItem.title = L10n.users_view_toolbar_title
    }

    // MARK: TableView methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.nameOfClass, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        let user = items[indexPath.row]
        cell.setupWithUser(user)
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = items[indexPath.row]
        flowDelegate?.showUserDetail(userId: user.id)
    }

    // MARK: Additional methods
}
