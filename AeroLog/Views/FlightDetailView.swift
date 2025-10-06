//
//  FlightDetailView.swift
//  AeroLog
//
//  Created by Yu-Han on 6/9/2025.
//  Flight detail screen: weather, gate, and timing
//

import SwiftUI

struct FlightDetailView: View {
    let task: FlightTask
    
    // Weather states
    @State private var weather: WeatherData?
    @State private var isLoadingWeather = true
    @State private var weatherError: String?
    
    // Weather API service
    private let weatherService = WeatherService()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // Weather Block
                Section {
                    if isLoadingWeather {
                        ProgressView("Loading weather...")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    } else if let weather = weather {
                        HStack(spacing: 16) {
                            VStack(alignment: .leading) {
                                Text("Weather at Arrival")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                Text("\(weather.current.temp_c, specifier: "%.1f") °C")
                                    .font(.title)
                                    .bold()

                                Text(weather.current.condition.text)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 48, height: 48)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    } else if let error = weatherError {
                        Text("⚠️ Failed to load weather: \(error)")
                            .foregroundColor(.red)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                }

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
        .task {
            await loadWeather()
        }
    }

    // MARK: - Load weather for arrival city
    private func loadWeather() async {
        do {
            let data = try await weatherService.fetchWeather(for: task.arrival)
            await MainActor.run {
                self.weather = data
                self.isLoadingWeather = false
            }
        } catch {
            await MainActor.run {
                self.weatherError = error.localizedDescription
                self.isLoadingWeather = false
            }
        }
    }
}
