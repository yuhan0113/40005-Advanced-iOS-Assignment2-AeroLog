//  Created by Yu-Han on 6/9/2025.
//  UI to add a new flight task

import SwiftUI

struct AddFlightView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TaskViewModel

    @State private var flightNumber = ""
    @State private var departure = ""
    @State private var arrival = ""
    @State private var departureTimeDate = Date()
    @State private var arrivalTimeDate = Date()
    @State private var dueDate = Date()
    @State private var selectedAirline = Airline.qantas
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var searchText = ""

    var body: some View {
        Form {
            Section(header: Text("Select Airline")) {
                TextField("Search airline or code", text: $searchText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)

                if !searchText.isEmpty {
                    List {
                        ForEach(filteredAirlines) { airline in
                            HStack {
                                Image(systemName: airline.icon)
                                    .foregroundColor(airline.color)
                                VStack(alignment: .leading) {
                                    Text(airline.rawValue)
                                    Text(airline.code)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                if airline == selectedAirline {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedAirline = airline
                                searchText = ""
                                hideKeyboard()
                            }
                        }
                    }
                    .frame(maxHeight: 150)
                } else {
                    HStack {
                        Image(systemName: selectedAirline.icon)
                            .foregroundColor(selectedAirline.color)
                        Text("Selected: \(selectedAirline.rawValue)")
                            .foregroundColor(.secondary)
                    }
                }
            }

            Section(header: Text("Flight Info")) {
                TextField("Flight Number (e.g. QF123)", text: $flightNumber)
                    .autocapitalization(.allCharacters)

                TextField("From (e.g. Sydney)", text: $departure)
                TextField("To (e.g. Perth)", text: $arrival)

                DatePicker("Departure Time", selection: $departureTimeDate, displayedComponents: .hourAndMinute)
                DatePicker("Arrival Time", selection: $arrivalTimeDate, displayedComponents: .hourAndMinute)

                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }

            Button("Add Flight") {
                let departureTime = formatTime(departureTimeDate)
                let arrivalTime = formatTime(arrivalTimeDate)

                do {
                    try viewModel.addTask(title: flightNumber,
                                          flightNumber: flightNumber,
                                          departure: departure,
                                          arrival: arrival,
                                          departureTime: departureTime,
                                          arrivalTime: arrivalTime,
                                          dueDate: dueDate,
                                          airline: selectedAirline)
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
        .onChange(of: flightNumber) { newValue in
            let code = String(newValue.prefix(2)).uppercased()
            if let matched = Airline.allCases.first(where: { $0.code == code }) {
                selectedAirline = matched
            }
        }
    }

    // Filter airlines by name or code
    var filteredAirlines: [Airline] {
        if searchText.isEmpty {
            return Airline.allCases
        } else {
            return Airline.allCases.filter {
                $0.rawValue.localizedCaseInsensitiveContains(searchText) ||
                $0.code.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // Format Date to time string (e.g. "3:45 PM")
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// Helper to dismiss keyboard on tap
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
#endif
