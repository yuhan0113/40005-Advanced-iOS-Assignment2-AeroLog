import XCTest
@testable import AeroLog

final class AerologTests: XCTestCase {

    func testFlightTaskMarkCompleted() {
        let task = FlightTask(
            title: "QF1 Sydney to Perth",
            flightNumber: "QF1",
            departure: "Sydney",
            arrival: "Perth",
            departureTime: "10:00AM",
            arrivalTime: "3:00PM",
            dueDate: Date()
        )

        XCTAssertFalse(task.isCompleted)
        task.markCompleted()
        XCTAssertTrue(task.isCompleted)
    }

    @MainActor func testAddValidTaskToViewModel() throws {
        let viewModel = TaskViewModel()

        try viewModel.addTask(
            title: "QF2",
            flightNumber: "QF2",
            departure: "Melbourne",
            arrival: "Brisbane",
            departureTime: "9:00AM",
            arrivalTime: "11:00AM",
            dueDate: Date()
        )

        XCTAssertEqual(viewModel.tasks.count, 1)
    }

    @MainActor func testAddInvalidTaskThrowsError() {
        let viewModel = TaskViewModel()

        XCTAssertThrowsError(
            try viewModel.addTask(
                title: "",
                flightNumber: "",
                departure: "Melbourne",
                arrival: "Brisbane",
                departureTime: "9:00AM",
                arrivalTime: "11:00AM",
                dueDate: Date()
            )
        ) { error in
            XCTAssertEqual(error as? TaskError, TaskError.invalidInput)
        }
    }
}
