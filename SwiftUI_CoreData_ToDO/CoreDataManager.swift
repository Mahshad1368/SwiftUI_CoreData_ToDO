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
    
    let persistenContainer: NSPersistentContainer
    
    private init() {
        
        persistenContainer = NSPersistentContainer(name: "CoreData_ToDo")
        
        persistenContainer.loadPersistentStores {
            (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    
}
