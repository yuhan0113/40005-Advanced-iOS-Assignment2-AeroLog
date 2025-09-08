//  Created by Yu-Han on 6/9/2025.
//  UI for single flight task

import SwiftUI

struct FlightCardView: View {
    let task: FlightTask

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                // Airline icon + name
                HStack(spacing: 8) {
                    Image(systemName: task.airline.icon)
                        .foregroundColor(task.airline.color)
                    Text(task.airline.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }

                Spacer()

                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }

            Text("✈️ \(task.flightNumber)")
                .font(.headline)

            Text("\(task.departure) → \(task.arrival)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("\(task.departureTime) - \(task.arrivalTime)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}
