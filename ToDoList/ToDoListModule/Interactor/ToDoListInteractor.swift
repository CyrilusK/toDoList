//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

final class ToDoListInteractor: ToDoListInteractorInputProtocol {
    weak var output: ToDoListOutputProtocol?
    
    func fetchTasks() {
        ToDoService().fetchTasks { [weak self] result in
            switch result {
            case .success(let tasks):
                DispatchQueue.main.async {
                    self?.output?.didFetchTasks(tasks)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.output?.didFailToFetchTasks(error)
                }
            }
        }
    }
}
