# 40005-Advanced-iOS-Assignment2-AeroLog
The app for user to track and log their flights

# ✈️ Aerolog — Travel Task Management App

_Aerolog_ is a SwiftUI-based iOS application designed to help travellers manage trip-related tasks with clarity and ease. Developed for **Assessment Task 2** in the subject **40005 Advanced iOS**, this project showcases the integration of **object-oriented** and **protocol-oriented** programming, clean MVVM architecture, structured error handling, unit testing, and proper version control with Git.

---

## 📦 Features

- Manage tasks related to travel (e.g., flights, packing, bookings)
- Add, edit, delete travel tasks with ease
- Toggle task completion
- Date-based sorting
- Polished UI following Apple HIG (Human Interface Guidelines)
- Error handling for empty inputs
- MVVM architecture for clean separation of concerns

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
- ContentView: Displays all tasks
- TaskFormView: Adds a new task
- TaskRowView: Displays individual task rows

---

## 🧯 Error Handling

Basic error handling is implemented to guide the user:
	•	Prevents empty input submission
	•	Validates required fields
	•	Future-proofed for extending to network or database errors

```swift
guard !newTitle.isEmpty else {
    print("Error: Title required")
    return
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
func testMarkTaskCompleted() {
    let task = BaseTask(title: "Pack passport", dueDate: Date())
    task.markCompleted()
    XCTAssertTrue(task.isCompleted)
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

## 📄 Reflective Report (Optional)

This report is not included but can be added if required. It would include:
	•	Personal reflections on design choices
	•	Lessons learned during development
	•	Thoughts on POP vs OOP trade-offs

---

## Author
Yu-Han Chang (John)

Bachelor of IT, University of Technology Sydney

Subject: 40005 Advanced iOS Development
