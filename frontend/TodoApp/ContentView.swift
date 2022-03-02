//
//  ContentView.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/1/22.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var tasks: [Todo] = []
    
    var body: some View {
        VStack{
            List(tasks) { task in
                VStack(alignment: .leading, spacing: 10){
                    Text(task.title).fontWeight(.bold)
                    Text("Created at:  \(task.createdAt)").font(.callout)
                    Text("Due date:  \(task.dueDate)").font(.callout)
                }
                
                }.task {
                    tasks = await Api().getTasks()
            }
            Button("create"){
                Task {
                    await Api().createTask(NewTask(title: "Created a todo lolz", dueDate: "2023-01-01"))
                }
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Todo: Codable, Identifiable {
    var id = UUID()
    var createdAt: String
    var title: String
    var dueDate: String
    var completed: Bool
}

struct NewTask: Codable {
    var title: String
    var dueDate: String
}

struct emptyTask: Codable{
    
}




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
    

    func createTask(_ newTask: NewTask) async -> [Todo]{
        let req = AF.request("http://localhost:3000/tasks", method: .post, parameters: newTask, encoder: JSONParameterEncoder.default)
        let createdTasks = try! await req.serializingDecodable([Todo].self).value
        return createdTasks
    }
    

}
