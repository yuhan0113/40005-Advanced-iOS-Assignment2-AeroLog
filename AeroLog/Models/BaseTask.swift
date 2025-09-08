//  Created by Yu-Han on 6/9/2025.
//  Base class implementing TravelTask

import Foundation

// Base class implementing common task behaviour
class BaseTask: TravelTask, Identifiable {
    let id: UUID
    var title: String
    var dueDate: Date
    var isCompleted: Bool

    init(title: String, dueDate: Date, isCompleted: Bool = false) {
        self.id = UUID()
        self.title = title
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }

    func markCompleted() {
        isCompleted = true
    }
}
