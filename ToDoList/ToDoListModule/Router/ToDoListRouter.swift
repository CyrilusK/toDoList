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

    func presentShareSheet(items: [String]) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = entry?.view
        entry?.present(activityViewController, animated: true, completion: nil)
    }
}
