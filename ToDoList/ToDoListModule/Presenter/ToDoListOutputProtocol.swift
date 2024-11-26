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
}
