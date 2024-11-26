//
//  TaskTableViewCellDelegate.swift
//  ToDoList
//
//  Created by Cyril Kardash on 26.11.2024.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func didToggleTaskCompletion(at cell: TaskTableViewCell)
}
