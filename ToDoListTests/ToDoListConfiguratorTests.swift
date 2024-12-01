//
//  ToDoListConfiguratorTests.swift
//  ToDoListTests
//
//  Created by Cyril Kardash on 01.12.2024.
//

import CoreData
import XCTest
@testable import ToDoList

final class ToDoListConfiguratorTests: XCTestCase {
    func testConfigure() {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let coreDataManager = CoreDataManager(context: context)
        
        let configurator = ToDoListConfigurator()
        let viewController = configurator.configure(coreDataManager: coreDataManager)
        
        XCTAssertTrue(viewController is ToDoListViewController)
        let view = viewController as! ToDoListViewController
        
        XCTAssertNotNil(view.output)
        XCTAssertTrue(view.output is ToDoListPresenter)
        let presenter = view.output as! ToDoListPresenter
        
        XCTAssertNotNil(presenter.view)
        XCTAssertTrue(presenter.view === view)
        
        XCTAssertNotNil(presenter.interactor)
        XCTAssertTrue(presenter.interactor is ToDoListInteractor)
        let interactor = presenter.interactor as! ToDoListInteractor
        
        XCTAssertNotNil(presenter.router)
        XCTAssertTrue(presenter.router is ToDoListRouter)
        let router = presenter.router as! ToDoListRouter
        
        XCTAssertNotNil(interactor.output)
        XCTAssertTrue(interactor.output === presenter)
        
        XCTAssertNotNil(router.entry)
        XCTAssertTrue(router.entry === view)
    }
}
