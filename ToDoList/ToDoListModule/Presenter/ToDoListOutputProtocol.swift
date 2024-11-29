//
//  ToDoListOutputProtocol.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

protocol ToDoListOutputProtocol: AnyObject {
    func viewDidLoad()
    func didFetchTasks(_ tasks: [Task])
    func didFailToFetchTasks(_ error: Error)
    func didSearchTextChange(_ text: String)
    func toggleTaskCompletion(at index: Int)
    func navigateToEditTask(_ task: Task)
    func deleteTask(_ task: Task)
    func navigateToCreateTask()
}
