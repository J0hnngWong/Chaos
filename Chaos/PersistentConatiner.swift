//
//  PersistentConatiner.swift
//  Chaos
//
//  Created by john on 2023/4/6.
//

import Foundation
import CoreData

public class PersistentContainer: NSPersistentContainer {
    
    enum ContainerType: String, CaseIterable {
        case main = "Chaos"
        
        func createContainer() -> PersistentContainer {
            let container = PersistentContainer(name: "Chaos")
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Unable to load persistent stores: \(error)")
                }
            }
            return container
        }
    }
    
    public static var main = ContainerType.main.createContainer()
    
    static func setup(type: ContainerType) {
        
    }
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
