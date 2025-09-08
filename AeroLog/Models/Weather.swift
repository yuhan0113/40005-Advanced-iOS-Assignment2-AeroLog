import SwiftUI

struct Weather {
    let temperature: String
    let description: String
    let iconName: String
}

extension Weather {
    static func random() -> Weather {
        let options = [
            Weather(temperature: "18°C", description: "Raining", iconName: "cloud.rain.fill"),
            Weather(temperature: "24°C", description: "Partly Cloudy", iconName: "cloud.sun.fill"),
            Weather(temperature: "30°C", description: "Sunny", iconName: "sun.max.fill"),
            Weather(temperature: "12°C", description: "Foggy", iconName: "cloud.fog.fill"),
            Weather(temperature: "15°C", description: "Windy", iconName: "wind"),
            Weather(temperature: "20°C", description: "Stormy", iconName: "cloud.bolt.rain.fill")
        ]
        return options.randomElement()!
    }
}
