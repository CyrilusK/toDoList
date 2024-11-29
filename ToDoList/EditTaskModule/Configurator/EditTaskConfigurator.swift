//
//  EditTaskConfigurator.swift
//  ToDoList
//
//  Created by Cyril Kardash on 29.11.2024.
//

import UIKit

final class EditTaskConfigurator {
    func configure(task: Task, delegate: EditTaskDelegate) -> UIViewController {
        let view = EditTaskViewController()
        let presenter = EditTaskPresenter(task: task)
        //let interactor = EditTaskInteractor()
        
        view.output = presenter
        presenter.view = view
        presenter.delegate = delegate
        //presenter.interactor = interactor
        //interactor.output = presenter
        
        return view
    }
}
