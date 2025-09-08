//  Created by Yu-Han on 6/9/2025.
//  Handles task logic and state (MVVM)

import Foundation

@MainActor
class TaskViewModel: ObservableObject {
    @Published var tasks: [FlightTask] = []

    func addTask(title: String,
                 flightNumber: String,
                 departure: String,
                 arrival: String,
                 departureTime: String,
                 arrivalTime: String,
                 dueDate: Date,
                 airline: Airline) throws {
        
        guard !title.isEmpty, !flightNumber.isEmpty else {
            throw TaskError.invalidInput
        }

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

        tasks.append(newTask)
    }

    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleCompletion(for task: FlightTask) {
        task.isCompleted.toggle()
    }
}
