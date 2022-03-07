//
//  ViewModel.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/3/22.
//

//crudRepo

import Foundation
import Alamofire

class Api {
     
    @Published var tasks: [Todo] = []
    let url = "http://localhost:3000/tasks"
    @Published var noData = false
    
    func getTasks() async -> [Todo] {
        //creates request object assigned to a variable
        let req = AF.request("http://localhost:3000/tasks", method: .get, parameters: nil)
        let allTasks = try! await req.serializingDecodable([Todo].self).value
        return allTasks
    }    
    

    func createTask( _ newTask: NewTask) async {
        let req = AF.request("http://localhost:3000/tasks", method: .post, parameters: newTask, encoder: JSONParameterEncoder.default)
        _ = req.serializingDecodable(emptyTask.self, emptyResponseCodes: [201,203,204])
    }
    
    func deleteTask( new_id: Todo.ID) async {
        let req = AF.request("http://localhost:3000/tasks\(new_id)", method: .delete, parameters: nil)
        _ = req.serializingDecodable(emptyTask.self, emptyResponseCodes: [201,203,204])
    }
    
    func compeleteTask( new_id: Todo.ID) async {
        let completion: Parameters =  ["completed": "true"]
        let req = AF.request("http://localhost:3000/tasks\(new_id)", method: .put, parameters: completion)
        _ = req.serializingDecodable(emptyTask.self, emptyResponseCodes: [201,203,204])
    }
    
    //need id, duedate, and name of task
    func updateTask( new_id: Todo.ID, params: NewTask) async {
        let req = AF.request("http://localhost:3000/tasks\(new_id)", method: .put, parameters: params, encoder: JSONParameterEncoder.default)
        _ = req.serializingDecodable(emptyTask.self, emptyResponseCodes: [201,203,204])
    }

}



