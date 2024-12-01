//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

final class ToDoListInteractor: ToDoListInteractorInputProtocol {
    weak var output: ToDoListOutputProtocol?
    private let storageManager: CoreDataManager
    private let backgroundQueue = DispatchQueue(label: K.labelForCoreData, qos: .userInitiated)
    
    init(coreDataManager: CoreDataManager) {
        storageManager = coreDataManager
    }
    
    func fetchTasks() {
        backgroundQueue.async { [weak self] in
            let tasks = self?.storageManager.fetchTasks() ?? []
            DispatchQueue.main.async {
                self?.output?.didFetchTasks(tasks)
            }
        }
    }
    
    func loadTasksFromAPI() {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: K.hasLoadedTasks)
        if !isFirstLaunch {
            ToDoService().fetchTasks { [weak self] result in
                switch result {
                case .success(let tasks):
                    self?.backgroundQueue.async {
                        tasks.forEach({ self?.storageManager.createTask($0)})
                        UserDefaults.standard.setValue(true, forKey: K.hasLoadedTasks)
                    }
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
    
    func createTask(_ task: Task) {
        backgroundQueue.async { [weak self] in
            self?.storageManager.createTask(task)
        }
    }
    
    func updateTask(_ task: Task) {
        backgroundQueue.async { [weak self] in
            self?.storageManager.updateTask(task)
        }
    }
    
    func deleteTask(_ task: Task) {
        backgroundQueue.async { [weak self] in
            print("Will delete task: \(task)")
            self?.storageManager.deleteTask(task)
        }
    }
}
