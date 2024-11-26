//
//  Task.swift
//  ToDoList
//
//  Created by Cyril Kardash on 25.11.2024.
//

import UIKit

struct ToDoResponse: Decodable {
    let todos: [Task]?
    let total: Int
    let skip: Int
    let limit: Int
}

struct Task: Decodable {
    let id: Int
    let todo: String
    var completed: Bool
    let userId: Int
}

