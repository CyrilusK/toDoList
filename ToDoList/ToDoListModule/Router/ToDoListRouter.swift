//
//  ToDoListRouter.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

final class ToDoListRouter: ToDoListRouterInputProtocol {
    weak var entry: UIViewController?
    
    func presentTaskDetail(_ task: Task, _ delegate: EditTaskDelegate) {
        let editVC = EditTaskConfigurator().configure(task: task, delegate: delegate)
        entry?.navigationItem.backButtonTitle = K.back
        entry?.navigationController?.pushViewController(editVC, animated: true)
    }
}
