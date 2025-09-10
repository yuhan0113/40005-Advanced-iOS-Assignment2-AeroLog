//  Created by Yu-Han on 6/9/2025.
//  Flight detail screen: weather, gate, and timing

import SwiftUI

struct FlightDetailView: View {
    let task: FlightTask
    let weather: Weather = Weather.random()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // Weather Block
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Weather at Arrival")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text(weather.temperature)
                            .font(.title)
                            .bold()

                        Text(weather.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Image(systemName: weather.iconName)
                        .font(.system(size: 42))
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Airline Information Block
                HStack(spacing: 12) {
                    task.airline.displayImage
                        .frame(width: 36, height: 36)
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(task.airline.rawValue)
                            .font(.headline)
                        Text(task.flightNumber)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    if task.isCompleted {
                        Label("Completed", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)

                Divider()

                // Flight Route + Times
                VStack(alignment: .leading, spacing: 12) {
                    Text("Flight Route")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.departure.uppercased())
                                .font(.title2)
                            Text(task.departureTime)
                                .foregroundColor(.red)
                        }

                        Spacer()

                        Image(systemName: "airplane")
                            .font(.title2)

                        Spacer()

                        VStack(alignment: .trailing) {
                            Text(task.arrival.uppercased())
                                .font(.title2)
                            Text(task.arrivalTime)
                                .foregroundColor(.green)
                        }
                    }
                }
                .padding(.horizontal)

                Divider()

                // Terminal + Gate Info
                HStack {
                    Image(systemName: "door.left.hand.open")
                    Text("Terminal T1 · Gate C25")
                        .font(.headline)
                }
                .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Flight Details")
    }
}
