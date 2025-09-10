//  Created by Yu-Han on 6/9/2025.
//  Error types and handling logic

import Foundation

// Defines custom error types for task-related issues
enum TaskError: Error, LocalizedError {
    case invalidInput
    
    // Display user-readable error messages
    var errorDescription: String? {
        switch self {
        case .invalidInput:
            return "All required fields must be filled in."
        }
    }
}
