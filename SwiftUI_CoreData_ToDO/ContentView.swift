//
//  ContentView.swift
//  SwiftUI_CoreData_ToDO
//
//  Created by Mahshad Jafari on 15.08.24.
//

import SwiftUI


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.priority, ascending: false)])
    var tasks: FetchedResults<Task>
    
    @State private var presentSheet = false
    
    
    var body: some View {
        NavigationView {
    
            List(tasks){
                Text($0.title ?? "N/A")
                
            }
            .listStyle(.plain)
            .navigationTitle("ToDo's")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            
                            presentSheet.toggle()
                            
//                            let newTask = Task(context: viewContext)
//                            
//                                newTask.title = "Test Title 123"
//                                newTask.id = UUID()
//                                newTask.itemstamp = Date()
//                                newTask.priority = 0
//                                          
//                                try! viewContext.save()

//                            todoItem.append(.init(title: "Item \((0...9).randomElement()!)"))
                            
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
                .sheet(isPresented: $presentSheet, content: {
                    AddTaskView()
                })
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.shared.persistenContainer.viewContext)
      
}
