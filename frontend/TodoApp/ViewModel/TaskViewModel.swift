//
//  ViewModel.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/3/22.
//

import Foundation
import Alamofire

//View Model for all task calls.
@MainActor class TaskViewModel: ObservableObject {
    
    //published list of tasks from StateObject in contentview.
    //will refresh when any object changes (whenever an api call is made for this case) 
    @Published var tasks: [Todo] = []

    //get my data and set to an array
    init() { }
    
    func stringifyDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    //Calls repo to get all task
    func fetchAll() async {
        let allTasks = await Api().getTasks()
        self.tasks = allTasks
    }
    
    //Calls repo to get all tasks based on sorting criteria
    func sort(filter: String, sort: String, order: String) async {
        var taskFilter = 0
        var taskSort = ""
        var taskOrder = ""

        //pass in correct value for api call for filter
        if filter == "All Tasks" || filter.isEmpty {
            taskFilter = 2
        }
        if filter == "Completed Tasks" {
            taskFilter = 1
        }
        if filter == "Incomplete Tasks" {
            taskFilter = 0
        }
        //pass in correct value for api call for sort
        if sort.isEmpty {
            taskSort = sort
        }
        if sort == "Name" {
            taskSort = "title"
        }
        if sort == "Due Date" {
            taskSort = "dueDate"
        }
        if sort == "Created At" {
            taskSort = "createdAt"
        }
        //pass in correct value for api call for order
        if order.isEmpty{
            taskOrder = order
        }
        if order == "Ascending" {
            taskOrder = "ASC"
        }
        if order == "Descending" {
            taskOrder = "DESC"
        }
        
        let filterTodos = await Api().filterTasks(filter: taskFilter, sort: taskSort, order: taskOrder)
        self.tasks = filterTodos
    }
    
    //Calls repo to put updated tasks
    func updateTask(id: String, newTask: NewTask) async {
        await Api().updateTask(newID: id, params: newTask)
    }
    
    //Calls repo to create new task
    func addTask(newtitle: String, newdueDate: String) async {
         await Api().createTask(NewTask(title: newtitle, dueDate: newdueDate))
    }
    
    func deleteTask(id: String) async {
        await Api().deleteTask(newID: id)
    }

    //changes completion status before sending to repo
    func completion(id: String, completion: Bool) async {
        var taskStatus = true
        if completion == true {
            taskStatus = false
        }
        await Api().completeTask(newID: id, status: taskStatus)
    }
}
