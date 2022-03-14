//
//  ViewModel.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/3/22.
//


import Foundation
import Alamofire

//Porotocls for api class
protocol TodoRepo {
    func getTasks() async -> [Todo]
    func filterTasks(filter: Int, sort: String, order: String) async -> [Todo]
    func createTask( _ newTask: NewTask) async
    func deleteTask( newID: Todo.ID) async
    func completeTask( newID: Todo.ID, status: Bool) async
    func updateTask( newID: Todo.ID, params: NewTask) async
}

let url = "http://localhost:3000/tasks"

//Api call class
class Api : TodoRepo {
     
    //Api call for fetching all tasks
    func getTasks() async -> [Todo] {
        let req = AF.request(url, method: .get, parameters: nil)
        let allTasks = try! await req.serializingDecodable([Todo].self).value
        return allTasks
    }
    
    //Api call for fetching all tasks based on filter criteria
    func filterTasks(filter: Int, sort: String, order: String) async -> [Todo] {
        let req = AF.request("http://localhost:3000/tasks?completed=\(filter)", method: .get, parameters: nil)
        let allTasks = try! await req.serializingDecodable([Todo].self).value
        
        //if just selected: "see all"
        if sort.isEmpty && order.isEmpty && (filter == 2) {
            let req = AF.request("http://localhost:3000/tasks", method: .get, parameters: nil)
            let tasks = try! await req.serializingDecodable([Todo].self).value
            return tasks
        }
        //sort by completion only
        if sort.isEmpty && order.isEmpty && (filter == 1 || filter == 0) {
            let req = AF.request("http://localhost:3000/tasks?completed=\(filter)", method: .get, parameters: nil)
            let tasks = try! await req.serializingDecodable([Todo].self).value
            return tasks
        }
        //sort by task value only
        if !sort.isEmpty && order.isEmpty && filter == 2 {
            let req = AF.request("http://localhost:3000/tasks?sortBy=\(sort)", method: .get, parameters: nil)
            let tasks = try! await req.serializingDecodable([Todo].self).value
            return tasks
        }
        //sort by asc/desc only
        if sort.isEmpty && !order.isEmpty && filter == 2 {
            let req = AF.request("http://localhost:3000/tasks?orderBy=\(order)", method: .get, parameters: nil)
            let tasks = try! await req.serializingDecodable([Todo].self).value
            return tasks
        }
        //sort by filter and sort
        if !sort.isEmpty && order.isEmpty && (filter == 1 || filter == 0) {
            let req = AF.request("http://localhost:3000/tasks?completed=\(filter)&sortBy=\(sort)", method: .get, parameters: nil)
            let tasks = try! await req.serializingDecodable([Todo].self).value
            return tasks
        }
        //sort by filter and order
        if sort.isEmpty && !order.isEmpty && (filter == 1 || filter == 0) {
            let req = AF.request("http://localhost:3000/tasks?completed=\(filter)&orderBy=\(order)", method: .get, parameters: nil)
            let tasks = try! await req.serializingDecodable([Todo].self).value
            return tasks
        }
        //sort by sort and order
        if !sort.isEmpty && !order.isEmpty && filter == 2 {
            let req = AF.request("http://localhost:3000/tasks?sortBy=\(sort)&orderBy=\(order)", method: .get, parameters: nil)
            let tasks = try! await req.serializingDecodable([Todo].self).value
            return tasks
        }
        //sort by all 3 optional parameters
        if !sort.isEmpty && !order.isEmpty && (filter == 1 || filter == 0){
            let req = AF.request("http://localhost:3000/tasks?completed=\(filter)&sortBy=\(sort)&orderBy=\(order)", method: .get, parameters: nil)
            let tasks = try! await req.serializingDecodable([Todo].self).value
            return tasks
        }
        return allTasks
    }
    
    //Api call for creating a new task
    func createTask( _ newTask: NewTask) async {
        let req = AF.request(url, method: .post, parameters: newTask, encoder: JSONParameterEncoder.default)
        _ = try? await req.serializingDecodable(emptyTask?.self, emptyResponseCodes: [201,203,204]).value
    }
    
    //Api call for deleting a task
    func deleteTask( newID: Todo.ID) async {
        let req = AF.request("http://localhost:3000/tasks\(newID)", method: .delete, parameters: nil)
        _ = try? await req.serializingDecodable(emptyTask?.self, emptyResponseCodes: [201,203,204]).value
    }
    
    //Api call for changing a task to have opposite completion status
    func completeTask( newID: Todo.ID, status: Bool) async {
        let completion: Parameters =  ["completed": status]
        let req = AF.request("http://localhost:3000/tasks\(newID)", method: .put, parameters: completion)
        _ = try? await req.serializingDecodable(emptyTask?.self, emptyResponseCodes: [201,203,204]).value
    }
    
    //Api call for updating a task with new details
    func updateTask( newID: Todo.ID, params: NewTask) async {
        let req = AF.request("http://localhost:3000/tasks\(newID)", method: .put, parameters: params, encoder: JSONParameterEncoder.default)
        _ = try? await req.serializingDecodable(emptyTask?.self, emptyResponseCodes: [201,203,204]).value
    }
}



