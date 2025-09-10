//  Created by Yu-Han on 6/9/2025.
//  Unit tests for task completion and ViewModel logic

import XCTest
@testable import AeroLog

final class AerologTests: XCTestCase {
    
    // Test that a FlightTask can be marked as completed
    func testFlightTaskMarkCompleted() {
        let task = FlightTask(
            title: "QF1 Sydney to Perth",
            flightNumber: "QF1",
            departure: "Sydney",
            arrival: "Perth",
            departureTime: "10:00AM",
            arrivalTime: "3:00PM",
            dueDate: Date(),
            airline: .qantas
        )

        XCTAssertFalse(task.isCompleted)
        task.markCompleted()
        XCTAssertTrue(task.isCompleted)
    }
    
    // Test that adding a valid flight task works correctly
    @MainActor
    func testAddValidTaskToViewModel() throws {
        let viewModel = TaskViewModel()

        try viewModel.addTask(
            title: "QF2",
            flightNumber: "QF2",
            departure: "Melbourne",
            arrival: "Brisbane",
            departureTime: "9:00AM",
            arrivalTime: "11:00AM",
            dueDate: Date(),
            airline: .qantas
        )

        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks[0].flightNumber, "QF2")
    }
    
    // Test that invalid task input throws the appropriate error
    @MainActor
    func testAddInvalidTaskThrowsError() {
        let viewModel = TaskViewModel()

        XCTAssertThrowsError(
            try viewModel.addTask(
                title: "",
                flightNumber: "",
                departure: "Melbourne",
                arrival: "Brisbane",
                departureTime: "9:00AM",
                arrivalTime: "11:00AM",
                dueDate: Date(),
                airline: .qantas
            )
        ) { error in
            XCTAssertEqual(error as? TaskError, TaskError.invalidInput)
        }
    }
}
