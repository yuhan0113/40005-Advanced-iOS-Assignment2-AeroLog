//  Created by Yu-Han on 6/9/2025.
//  Flight-specific task model

import Foundation

// Subclass for flight-specific task with flight number & locations
class FlightTask: BaseTask {
    var flightNumber: String
    var departure: String
    var arrival: String
    var departureTime: String
    var arrivalTime: String

    init(title: String,
         flightNumber: String,
         departure: String,
         arrival: String,
         departureTime: String,
         arrivalTime: String,
         dueDate: Date) {
        
        self.flightNumber = flightNumber
        self.departure = departure
        self.arrival = arrival
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        super.init(title: title, dueDate: dueDate)
    }
}
