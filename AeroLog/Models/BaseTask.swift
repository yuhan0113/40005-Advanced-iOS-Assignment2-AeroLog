//
//  BaseTask.swift
//  AeroLog
//
//  Created by Yu-Han on 6/9/2025.
//  Base class implementing TravelTask
//

import Foundation

// Base class implementing common task behaviour
class BaseTask: TravelTask, Identifiable {
    var id: UUID          // now var so we can set from CoreData
    var title: String
    var dueDate: Date
    var isCompleted: Bool

    /// Allows passing in an existing id (for CoreData) or generates new one by default
    init(id: UUID = UUID(), title: String, dueDate: Date, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }

    // Marks task as completed
    func markCompleted() {
        isCompleted = true
    }
}
