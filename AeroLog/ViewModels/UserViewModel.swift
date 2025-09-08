import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: User

    init() {
        // Example default user
        self.user = User(
            name: "Test User",
            email: "test.user@example.com",
            frequentFlyerNumber: "QF123456",
            preferredAirline: .qantas
        )
    }

    func updateUser(name: String, email: String, ffNumber: String, airline: Airline) {
        user.name = name
        user.email = email
        user.frequentFlyerNumber = ffNumber
        user.preferredAirline = airline
    }
}
