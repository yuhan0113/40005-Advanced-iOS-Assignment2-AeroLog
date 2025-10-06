//
//  WearherService.swift
//  AeroLog
//
//  Created by Yu-Han on 7/10/2025.
//

import Foundation

// MARK: - Weather Data Model
struct WeatherData: Decodable {
    struct Current: Decodable {
        let temp_c: Double
        let condition: Condition
    }
    struct Condition: Decodable {
        let text: String
        let icon: String
    }
    let current: Current
}

// MARK: - Weather API Service
class WeatherService {
    private let apiKey = Secrets.weatherAPIKey

    func fetchWeather(for city: String) async throws -> WeatherData {
        guard let urlEncodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(urlEncodedCity)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(WeatherData.self, from: data)
    }
}
