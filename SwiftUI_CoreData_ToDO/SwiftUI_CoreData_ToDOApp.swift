//
//  SwiftUI_CoreData_ToDOApp.swift
//  SwiftUI_CoreData_ToDO
//
//  Created by Mahshad Jafari on 15.08.24.
//

import SwiftUI

@main
struct SwiftUI_CoreData_ToDOApp: App {
    
    let manager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.persistenContainer.viewContext)
        }
    }
}
