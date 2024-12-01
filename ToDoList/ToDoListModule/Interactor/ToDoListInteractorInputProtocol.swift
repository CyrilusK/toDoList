//
//  ToDoListInteractorInputProtocol.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

protocol ToDoListInteractorInputProtocol: AnyObject {
    func fetchTasks()
    func loadTasksFromAPI()
    func createTask(_ task: Task)
    func updateTask(_ task: Task)
    func deleteTask(_ task: Task)
}
