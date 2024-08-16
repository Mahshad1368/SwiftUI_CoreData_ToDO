//
//  AddTaskView.swift
//  SwiftUI_CoreData_ToDO
//
//  Created by Mahshad Jafari on 15.08.24.
//

import SwiftUI

struct AddTaskView: View {
    
    
    @Environment (\.presentationMode) var presentationmode
    @Environment (\.managedObjectContext) var viewContext
    
    @State private var title: String
    @State private var priority: Int
    private var task: Task?
    
    init(task: Task? = nil) {
        self.task = task
        self._title = State(initialValue: task?.title ?? "")
        self._priority = State(initialValue: Int(task?.priority ?? 0))
    }
    
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Title")) {
                    TextField("Aufräume", text: $title)
                }
                Section(header: Text("Priorität")) {
                    Picker("", selection: $priority) {
                        Text("Normal").tag(0)
                        Text("!!").tag(1)
                        Text("!!!").tag(2)
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
           
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen") {
                        presentationmode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Speichern") {
                        if let task = task {
                           updateTask(task: task)
                        }else {
                            creatTask()
                        }
                        presentationmode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            })
            .navigationTitle(task == nil ? "Neue Aufgabe" : "Bearbeiten")
            .navigationBarTitleDisplayMode(task == nil ? .large : .inline)
        }
    }
    
    func updateTask(task: Task) {
        task.title = title
        task.priority = Int16(priority)
        
        try? viewContext.save()
    }
    
        func creatTask () {
            let task = Task(context: viewContext)
            task.id = UUID()
            task.timestamp = Date()
            task.priority = Int16(priority)
            task.title = title
            
            try! viewContext.save()
        }
    }


#Preview {
    AddTaskView()
}
