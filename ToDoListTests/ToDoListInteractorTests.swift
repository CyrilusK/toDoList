//
//  ToDoListInteractorTests.swift
//  ToDoListTests
//
//  Created by Cyril Kardash on 02.12.2024.
//

import CoreData
import XCTest
@testable import ToDoList

final class ToDoListInteractorTests: XCTestCase {
    var interactor: ToDoListInteractor!
    var mockOutput: MockToDoListOutput!
    var mockCoreDataManager: MockCoreDataManager!
    
    override func setUp() {
        super.setUp()
        mockCoreDataManager = MockCoreDataManager()
        mockOutput = MockToDoListOutput()
        interactor = ToDoListInteractor(coreDataManager: mockCoreDataManager)
        interactor.output = mockOutput
    }
    
    func testFetchTasks() {
        let expectation = self.expectation(description: "Fetching tasks")
        interactor.fetchTasks()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockCoreDataManager.fetchTasksCalled)
            XCTAssertTrue(self.mockOutput.didFetchTasksCalled)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testLoadTasksFromAPI() {
        let expectation = self.expectation(description: "Loading tasks")
        interactor.fetchTasks()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockCoreDataManager.fetchTasksCalled)
            XCTAssertTrue(self.mockOutput.didFetchTasksCalled)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testCreateTask() {
        let task = Task(id: 1, todo: "New Task", desc: "", completed: false, userId: 1, date: Date())
        interactor.createTask(task)
        
        XCTAssertEqual(mockCoreDataManager.mockTasks.count, 1)
    }
    
    func testUpdateTask() {
        let originalTask = Task(id: 1, todo: "Original Task", desc: "", completed: false, userId: 1, date: Date())
        interactor.createTask(originalTask)
        
        let updatedTask = Task(id: 1, todo: "Updated Task", desc: "", completed: false, userId: 1, date: Date())
        interactor.updateTask(updatedTask)
        
        XCTAssertEqual(mockCoreDataManager.mockTasks.first?.todo, "Updated Task")
    }
    
    func testDeleteTask() {
        let task = Task(id: 1, todo: "Task to Delete", desc: "", completed: false, userId: 1, date: Date())
        interactor.createTask(task)
        interactor.deleteTask(task)
        
        XCTAssertTrue(mockCoreDataManager.mockTasks.isEmpty)
    }
}

class MockToDoListOutput: ToDoListOutputProtocol {
    var didFetchTasksCalled = false

    func viewDidLoad() {}

    func didFetchTasks(_ tasks: [Task]) {
        didFetchTasksCalled = true
    }

    func didFailToFetchTasks(_ error: Error) {}

    func didSearchTextChange(_ text: String) {}

    func toggleTaskCompletion(at index: Int) {}

    func navigateToEditTask(_ task: Task) {}

    func deleteTask(_ task: Task) {}

    func navigateToCreateTask() {}

    func navigateToShareSheet(_ task: Task) {}
}

class MockCoreDataManager: CoreDataManagerProtocol {
    var fetchTasksCalled = false
    
    var mockTasks: [Task] = []
    
    func createTask(_ task: Task) {
        mockTasks.append(task)
    }
    
    func fetchTasks() -> [Task] {
        fetchTasksCalled = true
        return mockTasks
    }
    
    func updateTask(_ task: Task) {
        if let index = mockTasks.firstIndex(where: { $0.id == task.id }) {
            mockTasks[index] = task
        }
    }
    
    func deleteTask(_ task: Task) {
        mockTasks.removeAll { $0.id == task.id }
    }
}

