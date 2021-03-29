//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

// swiftlint:disable file_length

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class UserRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let databaseProvider = DatabaseProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    private func setupDependencies() -> ProviderDependencyMock {
        return ProviderDependencyMock(
            databaseProvider: databaseProvider,
            networkProvider: networkProvider
        )
    }
    
    // MARK: Tests
    
    func testCreateValid() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(User.self)
        
        repository.create(.valid).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testCreateExistingEmail() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        networkProvider.observableRequestReturnError = RepositoryError(statusCode: StatusCode.httpConflict, message: "")
        let output = scheduler.createObserver(User.self)

        repository.create(.existingEmail).bind(to: output).disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(output.events, [
            .error(0, RepositoryError(statusCode: StatusCode.httpConflict, message: ""))
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 0)
    }
    
    func testReadLocal() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        databaseProvider.observableObjectReturnValue = NETUser.stubDomain.databaseModel
        let output = scheduler.createObserver(User.self)

        repository.read(.local, id: NETUser.stubDomain.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableObjectCallsCount, 1)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 0)
    }
    
    func testReadRemote() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(User.self)

        repository.read(.remote, id: NETUser.stubDomain.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableObjectCallsCount, 0)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testReadBoth() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        databaseProvider.observableObjectReturnValue = NETUser.stubDomain.databaseModel
        let output = scheduler.createObserver(User.self)

        repository.read(.both, id: NETUser.stubDomain.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableObjectCallsCount, 1)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testListLocal() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        databaseProvider.observableCollectionReturnValue = NETUser.stubListDomain.map { $0.databaseModel }
        let output = scheduler.createObserver([User].self)

        repository.list(.local, page: 0, sortBy: "id").bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubListDomain),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableCollectionCallsCount, 1)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveCollectionCallsCount, 0)
    }
    
    func testListRemote() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver([User].self)

        repository.list(.remote, page: 0, sortBy: "id").bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubListDomain),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableCollectionCallsCount, 0)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveCollectionCallsCount, 1)
    }

    func testListBoth() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        databaseProvider.observableCollectionReturnValue = NETUser.stubListDomain.map { $0.databaseModel }
        let output = scheduler.createObserver([User].self)

        repository.list(.both, page: 0, sortBy: "id").bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubListDomain),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableCollectionCallsCount, 1)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveCollectionCallsCount, 1)
    }
    
    func testUpdateLocal() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(User.self)

        repository.update(.local, user: NETUser.stubDomain).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testUpdateRemote() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(User.self)

        repository.update(.remote, user: NETUser.stubDomain).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testUpdateBoth() {
        let repository = UserRepositoryImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(User.self)

        repository.update(.both, user: NETUser.stubDomain).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 2)
    }
}
