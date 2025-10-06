//
//  WeatherService.swift
//  AeroLog
//
//  Created by Yu-Han on 7/10/2025.
//

import Foundation
import CoreLocation

// MARK: - API Response Models

struct WeatherResponse: Decodable {
    let current: CurrentWeather
}

struct CurrentWeather: Decodable {
    let temperature: Double
    let weather_descriptions: [String]
    let weather_icons: [String]
}

// MARK: - WeatherService

class WeatherService {
    private let apiKey = "352013280e69464db4a131238250610"
    private let baseURL = "http://api.weatherstack.com/current"

    /// Fetches weather using lat/lon coordinates
    func fetchWeather(for location: CLLocationCoordinate2D) async throws -> WeatherResponse {
        let query = "\(location.latitude),\(location.longitude)"
        guard let url = URL(string: "\(baseURL)?access_key=\(apiKey)&query=\(query)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
