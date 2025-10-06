//
//  TaskViewModel.swift
//  AeroLog
//
//  Created by Yu-Han on 6/9/2025.
//  Handles task logic and state (MVVM) with CoreData persistence
//

import Foundation
import CoreData

@MainActor
class TaskViewModel: ObservableObject {
    @Published var tasks: [FlightTask] = []
    
    private let context = CoreDataManager.shared.context
    
    init() {
        fetchTasks()
    }
    
    /// Adds a new flight task with basic input validation and CoreData persistence
    func addTask(title: String,
                 flightNumber: String,
                 departure: String,
                 arrival: String,
                 departureTime: String,
                 arrivalTime: String,
                 dueDate: Date,
                 airline: Airline) throws {
        
        // Ensure required fields are provided
        guard !title.isEmpty, !flightNumber.isEmpty else {
            throw TaskError.invalidInput
        }

        // Create the model object
        let newTask = FlightTask(
            title: title,
            flightNumber: flightNumber,
            departure: departure,
            arrival: arrival,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            dueDate: dueDate,
            airline: airline
        )

        // Save to CoreData
        let entity = FlightTaskEntity(context: context)
        entity.id = newTask.id
        entity.title = newTask.title
        entity.flightNumber = newTask.flightNumber
        entity.departure = newTask.departure
        entity.arrival = newTask.arrival
        entity.departureTime = newTask.departureTime
        entity.arrivalTime = newTask.arrivalTime
        entity.dueDate = newTask.dueDate
        entity.airlineRaw = newTask.airline.rawValue
        entity.isCompleted = newTask.isCompleted

        saveAndReload()
    }
    
    /// Fetches tasks from CoreData
    func fetchTasks() {
        let request: NSFetchRequest<FlightTaskEntity> = FlightTaskEntity.fetchRequest()
        do {
            let entities = try context.fetch(request)
            self.tasks = entities.map {
                FlightTask(
                    id: $0.id ?? UUID(),
                    title: $0.title ?? "",
                    flightNumber: $0.flightNumber ?? "",
                    departure: $0.departure ?? "",
                    arrival: $0.arrival ?? "",
                    departureTime: $0.departureTime ?? "",
                    arrivalTime: $0.arrivalTime ?? "",
                    dueDate: $0.dueDate ?? Date(),
                    airline: Airline(rawValue: $0.airlineRaw ?? "") ?? .qantas,
                    isCompleted: $0.isCompleted
                )
            }
        } catch {
            print("❌ Failed to fetch tasks: \(error.localizedDescription)")
        }
    }
    
    /// Removes a task at given index (CoreData + local array)
    func removeTask(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            
            let request: NSFetchRequest<FlightTaskEntity> = FlightTaskEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
            
            if let entity = try? context.fetch(request).first {
                context.delete(entity)
            }
        }
        saveAndReload()
    }
    
    /// Toggles completion state of a given task (updates CoreData)
    func toggleCompletion(for task: FlightTask) {
        task.isCompleted.toggle()
        
        let request: NSFetchRequest<FlightTaskEntity> = FlightTaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        if let entity = try? context.fetch(request).first {
            entity.isCompleted = task.isCompleted
            saveAndReload()
        }
    }
    
    /// Saves CoreData context and reloads tasks
    private func saveAndReload() {
        CoreDataManager.shared.saveContext()
        fetchTasks()
    }
}
