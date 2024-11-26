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
    
    func viewDidLoad() {
        view?.setupUI()
        interactor?.fetchTasks()
    }
    
    func didFetchTasks(_ tasks: [Task]) {
        view?.showTasks(tasks)
    }
    
    func didFailToFetchTasks(_ error: Error) {
        if let tasksFetchError = error as? ToDoServiceError {
            view?.showError("Failed to load tasks: \(tasksFetchError.errorDescription)")
        } else {
            view?.showError("Failed to load tasks: \(error.localizedDescription)")
        }
    }
}
