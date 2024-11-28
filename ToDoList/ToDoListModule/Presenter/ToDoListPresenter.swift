//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

final class ToDoListPresenter: ToDoListOutputProtocol {
    weak var view: ToDoListViewInputProtocol?
    var interactor: ToDoListInteractorInputProtocol?
    var router: ToDoListRouterInputProtocol?
    
    private var tasks: [Task] = [] {
        didSet {
            updateView()
        }
    }
    private var filteredTasks: [Task] = []
    private var isSearchActive: Bool = false
    
    func viewDidLoad() {
        view?.setupUI()
        interactor?.fetchTasks()
    }
    
    func didFetchTasks(_ tasks: [Task]) {
        self.tasks = tasks
    }
    
    func didFailToFetchTasks(_ error: Error) {
        if let tasksFetchError = error as? ToDoServiceError {
            view?.showError("Failed to load tasks: \(tasksFetchError.errorDescription)")
        } else {
            view?.showError("Failed to load tasks: \(error.localizedDescription)")
        }
    }
    
    func didSearchTextChange(_ text: String) {
        isSearchActive = !text.isEmpty
        filteredTasks = isSearchActive ? tasks.filter { $0.todo.lowercased().contains(text.lowercased()) } : []
        updateView()
    }
    
    private func updateView() {
        let tasksForDisplay = isSearchActive ? filteredTasks : tasks
        view?.showTasks(tasksForDisplay, totalCount: tasks.count)
    }
    
    func toggleTaskCompletion(at index: Int) {
        if isSearchActive {
            let taskId = filteredTasks[index].id
            guard let originalIndex = tasks.firstIndex(where: { $0.id == taskId }) else { return }
            tasks[originalIndex].completed.toggle()
            filteredTasks[index].completed.toggle()
        } else {
            tasks[index].completed.toggle()
        }
        updateView()
    }
    
    func navigateToEditTask(_ task: Task) {
        router?.presentTaskDetail(task)
    }
}
