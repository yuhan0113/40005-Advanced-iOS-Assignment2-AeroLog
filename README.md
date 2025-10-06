#### Link to Git Repository: https://github.com/yuhan0113/40005-Advanced-iOS-Assignment2-AeroLog.git

## 40005-Advanced-iOS-Assignment2-AeroLog
## 40005-Advanced-iOS-Assignment3-AeroLog (Extended from Assignment 2)
## ✈️ AeroLog — Travel Task Management App

_Aerolog_ is a SwiftUI-based iOS application designed to help travellers manage trip-related tasks with clarity and ease. Developed for **Assessment Task 2** in the subject **40005 Advanced iOS**, this project showcases the integration of **object-oriented** and **protocol-oriented** programming, clean MVVM architecture, structured error handling, unit testing, and proper version control with Git.

---

## Updates for Assessment Task 3 (Project 2)
Aerolog has been extended to include more advanced iOS development features:

### ✅ New Features
- 💾 **CoreData Integration**: Persistent local storage of flight tasks
- ☁️ **Weather API**: Live weather at arrival using WeatherStack API
- 🗺️ **MapKit Support**: Route map showing departure and arrival cities
- 📍 **Location Permissions**: Uses CoreLocation for geocoding weather/map
- ⚙️ **Background Modes**: App supports background fetch for location/weather
- 🧪 **Improved Unit Tests**: Tests for Task models and ViewModel logic
- 🧼 **Refined UI**: Cleaner screens, better error handling, async feedback

---

## 📋 How to Run the App

### Requirements:
- Xcode 15+
- iOS 17+ device or simulator
- SwiftUI, Combine, CoreData, MapKit
- Free API key from https://www.weatherapi.com

### Setup:
1. Clone the repo:
    ```bash
    git clone https://github.com/yuhan0113/40005-Advanced-iOS-Assignment2-AeroLog.git
    ```
2. Open `AeroLog.xcodeproj` in Xcode.
3. In `WeatherService.swift`, replace the placeholder API key with:
    ```swift
    private let apiKey = "352013280e69464db4a131238250610"
    ```
4. Make sure CoreData `.xcdatamodeld` is added to the project and codegen is set to **Class Definition**.
5. Set Info.plist permissions:
    ```xml
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs your location to fetch weather updates.</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>This app needs your location even in background to support weather features.</string>
    ```
6. Build and run!

---

## 📱 App Usage Guide

Aerolog is designed for quick flight task management with a clean, intuitive UI. Here's a brief overview of how to use the app:

### 🛫 Dashboard (Home)
- Shows **“My Flights”** with upcoming flight tasks.
- If no tasks exist, you'll see a welcome message with an airplane icon.
- Tap **`+` Add Flight** (top-right) to enter a new flight.

### ➕ Add Flight
- Fill in flight number, departure/arrival cities, and times.
- Search or auto-detect airline from flight number (e.g. `QF123` → Qantas).
- Select due date, then tap **"Add Flight"** to save.
- Flight is stored using **CoreData**, visible on Dashboard.

### 📋 Flight Card
- Tap a flight to view details:
  - Live **weather** at arrival city (fetched via WeatherStack API)
  - Departure/arrival time and airport route
  - Completion status
  - Terminal info (static)

### 🗺️ Route Map
- From detail screen, view a **MapKit map** of departure and arrival cities.
- Geocoded via CoreLocation with annotations.

### 👤 User Profile
- Access from **top-left icon** on Dashboard.
- Allows editing of user name, email, and frequent flyer number (locally stored).

---

## 📦 Features

- Track flights with airline selection and scheduling (blur search supported)
- Auto-match airline IATA code from flight number (e.g. "QF123" -> Qantas)
- Searchable airline picker with logos (e.g. from asset images like `QF.png` represents Qantas, `CX.png` represents Cathay Pacific)
- Add, edit, and delete flight tasks
- Toggle flight completion status
- Weather preview on flight detail screen (random weather for demo purposes)
- User profile view (editable personal information, frequent flyer number)
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

Example:
```swift
    func testFlightTaskMarkCompleted() {
        let task = FlightTask(
            title: "QF1 Sydney to Perth",
            flightNumber: "QF1",
            departure: "Sydney",
            arrival: "Perth",
            departureTime: "10:00AM",
            arrivalTime: "3:00PM",
            dueDate: Date(),
            airline: .qantas
        )

        XCTAssertFalse(task.isCompleted)
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

## Author
Student: Yu-Han Chang (John)

Student ID: 14542423

Subject: 40005 Advanced iOS Development

Bachelor of IT, University of Technology Sydney
