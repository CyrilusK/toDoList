//
//  EditTaskOutputProtocol.swift
//  ToDoList
//
//  Created by Cyril Kardash on 29.11.2024.
//

import UIKit

protocol EditTaskOutputProtocol {
    func viewDidLoad()
    func didFinishEditingTask(_ title: String, _ desc: String, _ dateString: String)
}
