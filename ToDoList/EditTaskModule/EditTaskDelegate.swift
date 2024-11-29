//
//  EditTaskDelegate.swift
//  ToDoList
//
//  Created by Cyril Kardash on 29.11.2024.
//

import UIKit

protocol EditTaskDelegate: AnyObject {
    func didEditTask(_ task: Task)
}
