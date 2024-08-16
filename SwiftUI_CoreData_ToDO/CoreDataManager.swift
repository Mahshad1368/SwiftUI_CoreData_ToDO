//
//  CoreDataManager.swift
//  SwiftUI_CoreData_ToDOTests
//
//  Created by Mahshad Jafari on 15.08.24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    static var preview: CoreDataManager = {
        let manager = CoreDataManager(inMemory: true)
        let viewContext = manager.persistenContainer.viewContext
        
        for _ in 0..<2 {
            
            let task = Task(context: viewContext)
            task.id = UUID()
            task.title = "Mustertitile \((1...50).randomElement()!)"
            task.priority = (0...2).randomElement()!
            task.timestamp = Date()
            
        }
        try? viewContext.save()
      
        
        return manager
        
    }()
    
    let persistenContainer: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        
        persistenContainer = NSPersistentContainer(name: "CoreData_ToDo")
        
        if inMemory {
            persistenContainer.persistentStoreDescriptions.first!.url = URL(filePath: "dev/null")
        }
        
        persistenContainer.loadPersistentStores {
            (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    
}
