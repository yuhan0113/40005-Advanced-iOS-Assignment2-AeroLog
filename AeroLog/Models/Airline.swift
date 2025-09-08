import Foundation
import SwiftUI

// Enum to represent supported airlines
enum Airline: String, CaseIterable, Identifiable {
    case qantas = "Qantas"
    case virgin = "Virgin Australia"
    case jetstar = "Jetstar"
    case rex = "Rex"
    case air_new_zealand = "Air New Zealand"

    var id: String { self.rawValue }

    var icon: String {
        switch self {
        case .qantas:
            return ""
        case .virgin:
            return ""
        case .jetstar:
            return ""
        case .rex:
            return ""
        case .air_new_zealand:
            return "NZ.png"
        }
    }

    var color: Color {
        switch self {
        case .qantas: return .red
        case .virgin: return .purple
        case .jetstar: return .orange
        case .rex: return .blue
        case .air_new_zealand: return .black
        }
    }

    var code: String {
        switch self {
        case .qantas: return "QF"
        case .virgin: return "VA"
        case .jetstar: return "JQ"
        case .rex: return "ZL"
        case .air_new_zealand: return "NZ"
        }
    }
}
