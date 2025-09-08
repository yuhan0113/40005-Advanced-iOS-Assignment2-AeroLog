//  Created by Yu-Han on 6/9/2025.
//  UI for weather, gate, times

import SwiftUI

struct FlightDetailView: View {
    let task: FlightTask

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Simulated Weather Info
                HStack {
                    Text("18°C")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    VStack {
                        Image(systemName: "cloud.rain.fill")
                            .font(.largeTitle)
                        Text("Raining")
                            .font(.caption)
                    }
                }
                .padding()

                Divider()

                Text("Welcome to \(task.arrival)")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 12) {
                    // Dynamic airline display
                    HStack {
                        Image(systemName: task.airline.icon)
                            .foregroundColor(task.airline.color)
                        Text("\(task.airline.rawValue) \(task.flightNumber)")
                            .bold()
                            .foregroundColor(.primary)
                    }

                    Text("Arrive 5m Early")
                        .foregroundColor(.green)

                    Text("Terminal: T1 · Gate: C25")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    HStack {
                        Text(task.departureTime)
                            .foregroundColor(.red)
                        Text(task.departure.uppercased())
                            .bold()

                        Spacer()

                        Text(task.arrivalTime)
                            .foregroundColor(.green)
                        Text(task.arrival.uppercased())
                            .bold()
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Flight Details")
    }
}
