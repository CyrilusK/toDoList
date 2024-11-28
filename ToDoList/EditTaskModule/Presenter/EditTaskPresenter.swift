//
//  EditTaskPresenter.swift
//  ToDoList
//
//  Created by Cyril Kardash on 29.11.2024.
//

import UIKit

final class EditTaskPresenter: EditTaskOutputProtocol {
    weak var view: EditTaskViewInputProtocol?
    
    private var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    func viewDidLoad() {
        view?.setupWithTask(task)
    }
}
