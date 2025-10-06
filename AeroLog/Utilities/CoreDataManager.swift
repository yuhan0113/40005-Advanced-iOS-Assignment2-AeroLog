import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "AeroLogModel") // Match your .xcdatamodeld filename (no extension)
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("❌ Core Data failed: \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("❌ Error saving Core Data context: \(error.localizedDescription)")
        }
    }
}
