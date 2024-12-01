//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Cyril Kardash on 01.12.2024.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func createTask(_ task: Task)
    func fetchTasks() -> [Task]
    func updateTask(_ task: Task)
    func deleteTask(_ task: Task)
}

// MARK: - CRUD
final class CoreDataManager: CoreDataManagerProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createTask(_ task: Task) {
        let newTask = TaskEntity(context: context)
        newTask.id = Int64(task.id)
        newTask.todo = task.todo
        newTask.desc = task.desc
        newTask.completed = task.completed
        newTask.userId = Int64(task.userId)
        newTask.date = task.date
        saveContext()
    }
    
    func fetchTasks() -> [Task] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            let entities = try context.fetch(request)
            return entities.map { entity in
                Task(
                    id: Int(entity.id),
                    todo: entity.todo ?? "",
                    desc: entity.desc,
                    completed: entity.completed,
                    userId: Int(entity.userId),
                    date: entity.date)
            }
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }
    
    func updateTask(_ task: Task) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %lld", task.id)
        
        do {
            if let entity = try context.fetch(request).first {
                entity.todo = task.todo
                entity.desc = task.desc
                entity.completed = task.completed
                entity.date = task.date
                saveContext()
            }
        } catch {
            print("Failed to update task: \(error)")
        }
    }
    
    func deleteTask(_ task: Task) {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %lld", task.id)
        do {
            let entities = try context.fetch(request)
            for entity in entities {
                context.delete(entity)
            }
            saveContext()
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
    
    private func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
