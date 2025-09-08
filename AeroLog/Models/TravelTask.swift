//  Created by Yu-Han on 6/9/2025.
//  Protocol for all travel tasks

import Foundation

// Protocol defining shared travel task behaviour
protocol TravelTask {
    var id: UUID { get }
    var title: String { get set }
    var dueDate: Date { get set }
    var isCompleted: Bool { get set }

    func markCompleted()
}
