//
//  TaskModels.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/3/22.
//

import Foundation

//Model for each task
struct Todo: Codable, Identifiable {
    var id: String = UUID().uuidString
    var createdAt: String
    var title: String
    var dueDate: String
    let completed: Bool
}

//Model for a new task
struct NewTask: Codable {
    var title: String
    var dueDate: String
}

//Model for empty task
struct emptyTask: Codable{

}
