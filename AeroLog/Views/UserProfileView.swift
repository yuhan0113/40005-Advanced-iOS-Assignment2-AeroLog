import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserViewModel

    @State private var name = ""
    @State private var email = ""
    @State private var frequentFlyerNumber = ""
    @State private var preferredAirline = Airline.qantas

    var body: some View {
        Form {
            Section(header: Text("Personal Info")) {
                TextField("Full Name", text: $name)
                TextField("Email", text: $email)
            }

            Section(header: Text("Frequent Flyer")) {
                TextField("FF Number", text: $frequentFlyerNumber)
                Picker("Preferred Airline", selection: $preferredAirline) {
                    ForEach(Airline.allCases) { airline in
                        Text(airline.rawValue).tag(airline)
                    }
                }
            }

            Button("Save Changes") {
                viewModel.updateUser(
                    name: name,
                    email: email,
                    ffNumber: frequentFlyerNumber,
                    airline: preferredAirline
                )
            }
        }
        .onAppear {
            name = viewModel.user.name
            email = viewModel.user.email
            frequentFlyerNumber = viewModel.user.frequentFlyerNumber
            preferredAirline = viewModel.user.preferredAirline
        }
        .navigationTitle("User Profile")
    }
}
