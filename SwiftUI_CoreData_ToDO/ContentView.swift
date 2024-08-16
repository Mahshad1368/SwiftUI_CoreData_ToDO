//
//  ContentView.swift
//  SwiftUI_CoreData_ToDO
//
//  Created by Mahshad Jafari on 15.08.24.
//

import SwiftUI


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.priority, ascending: false), NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)])
    var tasks: FetchedResults<Task>
    
    @State private var presentSheet = false
    private var priorityRepresentation = ["", "!!", "!!!"]
    
    
    var body: some View {
        NavigationView {
            
            taskView
                .navigationTitle("ToDo's")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .disabled(tasks.isEmpty)
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            presentSheet.toggle()
                            
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
    @ViewBuilder
    var taskView: some View {
        if tasks.isEmpty {
            VStack(spacing: 30){
                Image(systemName: "tray.full")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text("Keine Aufgaben")
                    .font(.system(size: 30, weight: .semibold))
            }
            .foregroundColor(Color.black.opacity(0.4))
            
        }else {
            List {
                ForEach(tasks){task in
                    HStack {
                        Text(priorityRepresentation[Int(task.priority)])
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                        Text(task.title ?? "N/A")
                    }
                }
                .onDelete(perform: deletItem)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    
    func deletItem (offsets: IndexSet) {
        offsets.map { tasks[$0]}.forEach(viewContext.delete)
        //
        //        var taskToDelet = Array<Task>()
        //
        //        for index in offsets {
        //            taskToDelet.append(tasks[index])
        //        }
        //        for task in taskToDelet {
        //            viewContext.delete(task)
        //        }
        try? viewContext.save()
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.preview.persistenContainer.viewContext)
    
}
