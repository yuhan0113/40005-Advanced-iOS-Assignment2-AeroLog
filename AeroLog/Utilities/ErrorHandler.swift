//  Created by Yu-Han on 6/9/2025.
//  Error types and handling logic

import Foundation

enum TaskError: Error, LocalizedError {
    case invalidInput

    var errorDescription: String? {
        switch self {
        case .invalidInput:
            return "All required fields must be filled in."
        }
    }
}
