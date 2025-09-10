//  Created by Yu-Han on 6/9/2025.
//  UI for single flight task (dashboard card)

import SwiftUI

struct FlightCardView: View {
    let task: FlightTask
    // Individual flight task to display

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // Airline and flight info row
            HStack(spacing: 8) {
                Image(task.airline.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 4) {
                    
                    // Airline name
                    Text(task.airline.rawValue)
                        .font(.headline)
                    
                    // Flight number
                    Text(task.flightNumber)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()
                
                // Completion icon
                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            
            // Departure -> Arrival section
            HStack {
                VStack(alignment: .leading) {
                    Text(task.departure.uppercased())
                        .font(.subheadline)
                    Text(task.departureTime)
                        .font(.caption)
                        .foregroundColor(.red)
                }

                Spacer()

                Image(systemName: "airplane")
                    .font(.title2)

                Spacer()

                VStack(alignment: .trailing) {
                    Text(task.arrival.uppercased())
                        .font(.subheadline)
                    Text(task.arrivalTime)
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
