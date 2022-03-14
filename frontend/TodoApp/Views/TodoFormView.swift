//
//  TodoFormView.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/8/22.
//

import SwiftUI

//View for create / Update task
struct TodoFormView: View {

    var todoManager: TaskViewModel
    @ObservedObject var formVM: ToDoFormViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    TextField("Task name", text: $formVM.title)
                    DatePicker("Due Date", selection: $formVM.selectDate, displayedComponents: .date)
                }
            }
            .navigationTitle("Todo Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
        }
    }
}

//Extension that handles button controls
extension TodoFormView {
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var updateSaveButton: some View {
        Button( formVM.updating ? "Update" : "Create",
                action: {
            if formVM.updating {
                presentationMode.wrappedValue.dismiss()
                Task{
                    let newDate = todoManager.stringifyDate(date: formVM.selectDate)
                    await todoManager.updateTask(id: formVM.id!, newTask: NewTask(title: formVM.title, dueDate: newDate))
                    await todoManager.fetchAll()
                }
            } else {
                presentationMode.wrappedValue.dismiss()
                Task {
                    let newDate = todoManager.stringifyDate(date: formVM.selectDate)
                    await todoManager.addTask(newtitle: formVM.title, newdueDate: newDate)
                    await todoManager.fetchAll()
                }
            }
        })
        .disabled(formVM.isDisabled)
    }
}

