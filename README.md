### Link to Git Repository: https://github.com/yuhan0113/40005-Advanced-iOS-Assignment2-AeroLog.git

# 40005-Advanced-iOS-Assignment2-AeroLog
The app for user to track and log their flights

# ✈️ Aerolog — Travel Task Management App

_Aerolog_ is a SwiftUI-based iOS application designed to help travellers manage trip-related tasks with clarity and ease. Developed for **Assessment Task 2** in the subject **40005 Advanced iOS**, this project showcases the integration of **object-oriented** and **protocol-oriented** programming, clean MVVM architecture, structured error handling, unit testing, and proper version control with Git.

---

## 📦 Features

- Track flights with airline selection and scheduling
- Auto-match airline code from flight number (e.g. "QF123" → Qantas)
- Searchable airline picker with logos (e.g. from asset images like `QF.png`)
- Add, edit, and delete flight tasks
- Toggle flight completion status
- Weather preview on flight detail screen
- User profile view
- Error handling for invalid input
- Clean, responsive UI following Apple Human Interface Guidelines

---

## 🧠 Project Architecture: MVVM
Model -> ViewModel -> View

- **Model:** Defines task types using OOP and protocols
- **ViewModel:** Manages task logic and state
- **View (SwiftUI):** Renders task lists and input forms with reactive bindings

---

## 🧩 Object-Oriented Programming (OOP)

The app uses classes and inheritance to define base task logic and extend functionality for specialised task types.

### Example:

```swift
class BaseTask: TravelTask {
    var title: String
    var dueDate: Date
    var isCompleted: Bool
    ...
}

class FlightTask: BaseTask {
    var flightNumber: String
    var airline: Airline
}
```
- Encapsulation: Task state is encapsulated within model classes
- Inheritance: FlightTask and HotelTask inherit from BaseTask
- Abstraction: Task logic is abstracted into reusable base classes

---

## 🔗 Protocol-Oriented Programming (POP)

The app uses protocols to define consistent behavior across various task types, supporting modular and reusable code.

```swift
protocol TravelTask {
    var title: String { get set }
    var dueDate: Date { get set }
    var isCompleted: Bool { get set }

    func markCompleted()
}
```

- BaseTask, FlightTask, and other task types conform to TravelTask
- Encourages flexible code reuse across models

---

## 🖼️ SwiftUI Interface

The UI is implemented using SwiftUI, following Apple’s design principles:
- Responsive layout using Form and List
- Accessibility-conscious: readable font sizes, appropriate contrast
- Navigation with NavigationView, Section, and DatePicker
- Smooth user experience with toggle actions and animations

Key Views:
- ContentView: Flight dashboard
- AddFlightView: Add new flight
- FlightDetailView: Detailed info with weather
- UserProfileView: Editable user information
 
---

## 🧯 Error Handling

Basic error handling is implemented to guide the user:
	•	Prevents empty input submission
	•	Validates required fields
	•	Future-proofed for extending to network or database errors

```swift
guard !flightNumber.isEmpty else {
    throw TaskError.invalidInput
}
```

Could be expanded with .alert() or custom error views.

---

## 🧪 Unit Testing

Unit tests ensure core functionality is reliable:
- ✅ Task creation
- ✅ Marking tasks as completed
- ✅ ViewModel task addition and deletion
- ✅ Guarding against invalid input

Example test:
```swift
func testAddInvalidTaskThrowsError() {
    XCTAssertThrowsError(try viewModel.addTask(...)) { error in
        XCTAssertEqual(error as? TaskError, .invalidInput)
    }
}
```
---

## 🔀 Version Control (Git)
- Project tracked using Git from the beginning
- Meaningful commit history:
    - Initial MVVM setup
    - Added TravelTask protocol and BaseTask class
    - Implemented FlightTask subclass
    - Connected ViewModel to SwiftUI List
    - Added error handling for empty input    
- Hosted on GitHub:

---

## 📝 Challenges & Debugging Notes
💡 Challenge: Mapping multiple task types to single form UI
- Solution: Used BaseTask abstraction and simple switch-case in ViewModel

🐞 Bug: Input form submitting without validation
- Fix: Guard statements for required fields

🛠️ Debugging: Used Xcode’s View Debugger and print() tracing to verify model updates

---

## Author
Yu-Han Chang (John)

Bachelor of IT, University of Technology Sydney

Subject: 40005 Advanced iOS Development
