//
//  EditTaskPresenter.swift
//  ToDoList
//
//  Created by Cyril Kardash on 29.11.2024.
//

import UIKit

final class EditTaskPresenter: EditTaskOutputProtocol {
    weak var view: EditTaskViewInputProtocol?
    weak var delegate: EditTaskDelegate?
    
    private var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    func viewDidLoad() {
        view?.setupWithTask(task)
    }
    
    func didFinishEditingTask(_ title: String, _ desc: String, _ dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = K.dateFormat
        guard let date = dateFormatter.date(from: dateString) else { return }
        
        task.todo = title
        task.desc = desc
        task.date = date
        delegate?.didEditTask(task)
    }
}
