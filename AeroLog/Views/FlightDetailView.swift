//
//  FlightDetailView.swift
//  AeroLog
//
//  Created by Yu-Han on 6/9/2025.
//  Flight detail screen: weather, gate, and timing
//

import SwiftUI
import CoreLocation
import MapKit

struct FlightDetailView: View {
    let task: FlightTask
    @State private var weather: WeatherResponse?
    @State private var isLoading = true
    @State private var errorMessage: String?

    @State private var arrivalCoordinate: CLLocationCoordinate2D? // for map pin

    let weatherService = WeatherService()
    let geocoder = CLGeocoder()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // Weather Block
                if let weather = weather {
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Text("Weather at Arrival")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text("\(Int(weather.current.temperature))°C")
                                .font(.title)
                                .bold()

                            Text(weather.current.weather_descriptions.first ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        if let iconURL = URL(string: weather.current.weather_icons.first ?? "") {
                            AsyncImage(url: iconURL) { image in
                                image
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                } else if isLoading {
                    ProgressView("Fetching Weather…")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text("⚠️ \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }

                // Airline Block
                HStack(spacing: 12) {
                    task.airline.displayImage
                        .frame(width: 36, height: 36)

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

                // Flight Route
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

                // Terminal
                HStack {
                    Image(systemName: "door.left.hand.open")
                    Text("Terminal T1 · Gate C25")
                        .font(.headline)
                }
                .foregroundColor(.secondary)

                // Map showing arrival location
                if let coordinate = arrivalCoordinate {
                    Map(coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                        )
                    ), annotationItems: [MapPin(location: coordinate)]) { pin in
                        MapMarker(coordinate: pin.location, tint: .blue)
                    }
                    .frame(height: 220)
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Flight Details")
        .task {
            await fetchWeatherForArrival()
        }
    }

    // MARK: - Fetch Weather Using Arrival City
    func fetchWeatherForArrival() async {
        isLoading = true
        errorMessage = nil

        do {
            let placemarks = try await geocoder.geocodeAddressString(task.arrival)
            if let coordinate = placemarks.first?.location?.coordinate {
                self.arrivalCoordinate = coordinate
                self.weather = try await weatherService.fetchWeather(for: coordinate)
            } else {
                errorMessage = "Unable to find location for \(task.arrival)."
            }
        } catch {
            errorMessage = "Weather fetch failed: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

// Helper struct for Map annotation
struct MapPin: Identifiable {
    let id = UUID()
    let location: CLLocationCoordinate2D
}
