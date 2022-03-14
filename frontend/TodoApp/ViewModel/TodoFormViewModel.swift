//
//  TodoFormViewModel.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/8/22.
//

import Foundation

//View Model for creating/updating a task
class ToDoFormViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var dueDate = ""
    @Published var selectDate = Date()
    var id: String?

    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        title.isEmpty
    }
    
    //Init if create task (no data sent)
    init() { }
    
    //Init if update task, as will have title and duedate
    init(_ currentToDo: Todo) {
        self.title = currentToDo.title
        self.dueDate = currentToDo.dueDate
        id = currentToDo.id
    }
}
