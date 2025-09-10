//  Created by Yu-Han on 6/9/2025.
//  Manage user profile data (MVVM)

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: User
    
    // Initialises with a default example user
    init() {
        // Example default user
        self.user = User(
            name: "Test User",
            email: "test.user@example.com",
            frequentFlyerNumber: "QF123456",
            preferredAirline: .qantas
        )
    }
    
    // Updates user profile with new details
    func updateUser(name: String, email: String, ffNumber: String, airline: Airline) {
        user.name = name
        user.email = email
        user.frequentFlyerNumber = ffNumber
        user.preferredAirline = airline
    }
}
