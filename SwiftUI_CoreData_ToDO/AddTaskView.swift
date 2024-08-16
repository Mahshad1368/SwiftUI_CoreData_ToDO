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
    
    @State private var title = ""
    @State private var priority = 0
    
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
            .navigationTitle("Neue Aufgabe")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen") {
                        presentationmode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Speichern") {
                        creatTask()
                        presentationmode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            })
        }
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
