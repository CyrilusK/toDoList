//
//  ToDoListConfigurator.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

final class ToDoListConfigurator {
    func configure() -> UIViewController {
        let view = ToDoListViewController()
        let presenter = ToDoListPresenter()
        let interactor = ToDoListInteractor()
        let router = ToDoListRouter()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.entry = view
        
        return view
    }
}
