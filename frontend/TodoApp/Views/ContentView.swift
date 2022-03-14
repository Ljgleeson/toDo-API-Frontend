//
//  ContentView.swift
//  TodoApp
//
//  Created by Liam Gleeson on 3/1/22.
//

import SwiftUI
import Alamofire

//View for the home screen. Fills with tasks buttons
struct ContentView: View {
    //Content is the first view to create my object so it gets the call of stateobject
    @StateObject private var todoManager = TaskViewModel()
    @State private var showFilterView = false
    @State private var showCreateView = false
    @State private var showUpdateView = false
    @State var uptitle =  ""
    @State var upDate =  ""
    @State var upComplete = false
    @State var upId =  ""
    @State var UpCreated =  ""
    
    var body: some View {
        HStack{
            
            //create button
            Button(action: {
                showCreateView.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 40))
            }.offset(x:170, y: 35)
            .sheet(isPresented: $showCreateView) {
                TodoFormView(todoManager: todoManager, formVM: ToDoFormViewModel())
            }
             
            //Filter view button
            Button(action: {
                showFilterView.toggle()
            }, label: {
                Image(systemName: "list.triangle")
            }).buttonStyle(.bordered).foregroundColor(Color.blue)
                .offset(x:-170, y: 35)
                .sheet(isPresented: $showFilterView) {
                    FilterView { newFilter, newSort, newOrder in
                        Task {
                            await todoManager.sort(filter: newFilter, sort: newSort, order: newOrder)
                        }
                    }
                }
        }
        Text("Task Tracker")
        .task {
            await todoManager.fetchAll()
        }
        VStack {
                List(todoManager.tasks) { tasks in
                    //HStack of task details and buttons
                    HStack {
                        //VStack of task details
                        VStack(alignment: .leading, spacing: 10) {
                            Text(tasks.title)
                                .fontWeight(.bold)
                                            .strikethrough(tasks.completed)
                                            .foregroundColor(tasks.completed ? .red : Color(.label))
                            Text("Creation:  \(tasks.createdAt)").font(.callout)
                            Text("Due Date:  \(tasks.dueDate)").font(.callout)
                        }
                        Spacer()
                        //Vstack of create,update, and delete button
                        VStack {
                            //Change completion status
                            Button {
                                Task {
                                    await todoManager.completion(id: tasks.id, completion: tasks.completed)
                                    await todoManager.fetchAll()
                                  }
                            }label: {
                                Image(systemName: "checkmark")
                            }.buttonStyle(.bordered).foregroundColor(Color.green)
                            
                            //Update button (seems to be little buggy when all tasks deleted then try to update first one
                            Button(action: {
                                Task {
                                    await todoManager.fetchAll()
                                }
                                self.uptitle = tasks.title
                                self.upDate = tasks.dueDate
                                self.upId = tasks.id
                                self.upComplete = tasks.completed
                                self.UpCreated = tasks.createdAt
                                showUpdateView.toggle()
                            }){
                                Image(systemName: "pencil")
                            }.buttonStyle(.bordered).foregroundColor(Color.blue)
                            .sheet(isPresented: $showUpdateView) {
                                TodoFormView(todoManager: todoManager, formVM: ToDoFormViewModel(Todo(id: self.upId, createdAt: self.UpCreated, title: self.uptitle, dueDate: self.upDate, completed: self.upComplete)))
                            }
                                                     
                            //Delete a task
                            Button {
                                Task {
                                    await todoManager.deleteTask(id: tasks.id)
                                    await todoManager.fetchAll()
                                }
                                self.uptitle = ""
                                self.upDate = ""
                                self.upId = ""
                                self.upComplete = false
                                self.UpCreated = ""
                            } label: {
                                Image(systemName: "trash.fill")
                            }.buttonStyle(.bordered).foregroundColor(Color.red)
                        }
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
