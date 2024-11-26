//
//  ToDoListViewInputProtocol.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

protocol ToDoListViewInputProtocol: AnyObject {
    func setupUI()
    func showTasks(_ tasks: [Task])
    func showError(_ message: String)
}
