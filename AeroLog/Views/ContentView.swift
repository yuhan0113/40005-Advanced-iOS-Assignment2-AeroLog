//  Created by Yu-Han on 6/9/2025.
//  Dashboard UI shows "My Flights"

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 16) {
                
                // Empty state: Show welcome message and an icon
                if viewModel.tasks.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "airplane.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.blue)
                            .padding(.bottom, 8)

                        Text("Welcome to AeroLog")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("Start manage your trips by adding a flight")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                // List State: show flight task cards
                else {
                    List {
                        Section(header: Text("Upcoming Flights")) {
                            ForEach(viewModel.tasks) { task in
                                NavigationLink(destination: FlightDetailView(task: task)) {
                                    FlightCardView(task: task)
                                }
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                            }
                            .onDelete(perform: viewModel.removeTask)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Flights")
            
            // Toolbar button: profile (left), add flight (right)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddFlightView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: UserProfileView(viewModel: UserViewModel())) {
                        Image(systemName: "person.circle")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
