//  Created by Yu-Han on 6/9/2025.
//  Dashboard UI shows "My flight"

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.tasks) { task in
                    NavigationLink(destination: FlightDetailView(task: task)) {
                        FlightCardView(task: task)
                    }
                }
                .onDelete(perform: viewModel.removeTask)
            }
            .navigationTitle("My Flights")
            .toolbar {
                NavigationLink(destination: AddFlightView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
