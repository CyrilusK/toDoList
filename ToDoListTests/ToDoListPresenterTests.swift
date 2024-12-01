//
//  ToDoListPresenterTests.swift
//  ToDoListTests
//
//  Created by Cyril Kardash on 01.12.2024.
//

import XCTest
@testable import ToDoList

final class ToDoListPresenterTests: XCTestCase {
    var presenter: ToDoListPresenter!
    var mockView: MockToDoListViewInput!
    var mockInteractor: MockToDoListInteractorInput!
    var mockRouter: MockToDoListRouterInput!

    override func setUp() {
        super.setUp()
        presenter = ToDoListPresenter()
        mockView = MockToDoListViewInput()
        mockInteractor = MockToDoListInteractorInput()
        mockRouter = MockToDoListRouterInput()

        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }
    
    func testViewDidLoad() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(mockView.setupUICalled)
        XCTAssertTrue(mockInteractor.loadTasksFromAPICalled)
        XCTAssertTrue(mockInteractor.fetchTasksCalled)
    }
    
    func testDidFetchTasks() {
        let tasks = [Task(id: 1, todo: "Test Task", desc: "", completed: false, userId: 1)]
        presenter.didFetchTasks(tasks)
        
        XCTAssertEqual(mockView.displayedTasks?.count, 1)
        XCTAssertEqual(mockView.displayedTasks?.first?.todo, "Test Task")
    }
    
    func testDidFailToFetchTasks() {
        let error = ToDoServiceError.invalidURL
        presenter.didFailToFetchTasks(error)
        
        XCTAssertTrue(mockView.showErrorCalled)
    }
    
    func testDidSearchTextChange() {
        let text = "Test"
        presenter.didSearchTextChange(text)
        
        XCTAssertFalse(text.isEmpty)
    }
    
    func testToggleTaskCompletion() {
        let tasks = [Task(id: 1, todo: "Test Task", desc: "", completed: false, userId: 1)]
        presenter.didFetchTasks(tasks)
        presenter.toggleTaskCompletion(at: 0)
        
        XCTAssertTrue(mockInteractor.updateTaskCalled)
    }
    
    func testNavigateToEditTask() {
        let task = Task(id: 1, todo: "Test to edit", desc: "", completed: false, userId: 1)
        presenter.navigateToEditTask(task)

        XCTAssertTrue(mockRouter.presentTaskDetailCalled)
    }
    
    func testDeleteTask() {
        let tasks = [Task(id: 1, todo: "Task to delete", desc: "", completed: false, userId: 1)]
        presenter.didFetchTasks(tasks)
        presenter.deleteTask(tasks[0])
        
        XCTAssertTrue(mockInteractor.deleteTaskCalled)
    }
    
    func testNavigateToCreateTask() {
        presenter.navigateToCreateTask()

        XCTAssertTrue(mockInteractor.createTaskCalled)
        XCTAssertTrue(mockRouter.presentTaskDetailCalled)
    }
    
    func testNavigateToShareSheet() {
        let task = Task(id: 1, todo: "Task to share", desc: "", completed: false, userId: 1)
        presenter.navigateToShareSheet(task)
        
        XCTAssertTrue(mockRouter.presentShareSheetCalled)
    }
}

// MARK: - Mock Classes

class MockToDoListViewInput: ToDoListViewInputProtocol {
    var setupUICalled = false
    var showErrorCalled = false
    var displayedTasks: [Task]?
    
    func setupUI() {
        setupUICalled = true
    }
    
    func showTasks(_ tasks: [ToDoList.Task], totalCount: Int) {
        displayedTasks = tasks
    }
    
    func showError(_ message: String) {
        showErrorCalled = true
    }
}

class MockToDoListInteractorInput: ToDoListInteractorInputProtocol {
    var fetchTasksCalled = false
    var loadTasksFromAPICalled = false
    var createTaskCalled = false
    var updateTaskCalled = false
    var deleteTaskCalled = false
    
    func fetchTasks() {
        fetchTasksCalled = true
    }
    
    func loadTasksFromAPI() {
        loadTasksFromAPICalled = true
    }
    
    func createTask(_ task: ToDoList.Task) {
        createTaskCalled = true
    }
    
    func updateTask(_ task: ToDoList.Task) {
        updateTaskCalled = true
    }
    
    func deleteTask(_ task: ToDoList.Task) {
        deleteTaskCalled = true
    }
}

class MockToDoListRouterInput: ToDoListRouterInputProtocol {
    var presentTaskDetailCalled = false
    var presentShareSheetCalled = false
    
    func presentTaskDetail(_ task: ToDoList.Task, _ delegate: ToDoList.EditTaskDelegate) {
        presentTaskDetailCalled = true
    }
    
    func presentShareSheet(items: [String]) {
        presentShareSheetCalled = true
    }
}

