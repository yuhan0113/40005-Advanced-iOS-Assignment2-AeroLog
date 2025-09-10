//  Created by Yu-Han on 8/9/2025.
//  Airline supported with name, code, and image (logo)

import SwiftUI

// Supported airlines with name display, code, image and their colour
enum Airline: String, CaseIterable, Identifiable {
    case qantas = "Qantas"
    case virgin = "Virgin Australia"
    case jetstar = "Jetstar"
    case airchina = "Air China"
    case chinaairlines = "China Airlines"
    case emirates = "Emirates"
    case american = "American Airlines"
    case cathay = "Cathay Pacific"

    var id: String { self.rawValue }
    
    // IATA airline code (e.g. QF for Qantas)
    var code: String {
        switch self {
        case .qantas: return "QF"
        case .virgin: return "VA"
        case .jetstar: return "JQ"
        case .airchina: return "CA"
        case .chinaairlines: return "CI"
        case .emirates: return "EK"
        case .american: return "AA"
        case .cathay: return "CX"
        }
    }
    
    /// Asset image name (e.g. CX.png, QF.png)
    var imageName: String {
        return code
    }

    /// Fallback image view for logo (SF Symbol)
    @ViewBuilder
    var displayImage: some View {
        if UIImage(named: imageName) != nil {
            Image(imageName)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: "airplane.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
        }
    }
    
    /// Airlines branding colour
    var color: Color {
        switch self {
        case .qantas: return .red
        case .virgin: return .purple
        case .jetstar: return .orange
        case .airchina: return .blue
        case .chinaairlines: return .pink
        case .emirates: return .red
        case .american: return .gray
        case .cathay: return .green
        }
    }
}
