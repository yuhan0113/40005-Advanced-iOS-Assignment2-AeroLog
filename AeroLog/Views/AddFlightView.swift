//  Created by Yu-Han on 6/9/2025.
//  UI to add a new flight task

import SwiftUI

struct AddFlightView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TaskViewModel

    @State private var title = ""
    @State private var flightNumber = ""
    @State private var departure = ""
    @State private var arrival = ""
    @State private var departureTime = ""
    @State private var arrivalTime = ""
    @State private var dueDate = Date()
    @State private var showAlert = false
    @State private var errorMessage = ""

    var body: some View {
        Form {
            Section(header: Text("Flight Info")) {
                TextField("Task Title", text: $title)
                TextField("Flight Number", text: $flightNumber)
                TextField("From (e.g. Sydney)", text: $departure)
                TextField("To (e.g. Perth)", text: $arrival)
                TextField("Departure Time", text: $departureTime)
                TextField("Arrival Time", text: $arrivalTime)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }

            Button("Add Flight") {
                do {
                    try viewModel.addTask(title: title,
                                          flightNumber: flightNumber,
                                          departure: departure,
                                          arrival: arrival,
                                          departureTime: departureTime,
                                          arrivalTime: arrivalTime,
                                          dueDate: dueDate)
                    dismiss()
                } catch {
                    errorMessage = error.localizedDescription
                    showAlert = true
                }
            }
        }
        .navigationTitle("Add Flight")
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}
