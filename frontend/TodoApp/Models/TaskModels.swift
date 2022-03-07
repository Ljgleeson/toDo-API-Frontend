//
//  TaskModels.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/3/22.
//

import Foundation


struct Todo: Codable, Identifiable {
    
    var id = UUID()
    var createdAt: String
    var title: String
    var dueDate: String
    let completed: Bool
   /*
    var id: UUID {
        return self.uuid
    }
    */
    
}

struct UpdateTask: Codable, Identifiable {
    var id: UUID
    var title: String
    var dueDate: String
    
}

struct NewTask: Codable {
    var title: String
    var dueDate: String
}

struct emptyTask: Codable{
    
}
